/**
 * Copyright (C) David Castells-Rufas, CEPHIS, Universitat Autònoma de Barcelona
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
/* 
 * File:   WebServer.cpp
 * Author: dcr
 *
 * Created on July 3, 2018, 3:51 PM
 */

#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <string.h>
#include <sys/types.h>
#include <time.h> 


/**
 * Ignore request
 * @param connfd
 */
void readHttpRequest(int connfd)
{
    int ret;
    unsigned char buffer[1000];
    
    printf("HTTP REQUEST:");
    
    do
    {
        unsigned char v;
        ret = read(connfd, &buffer, sizeof(buffer));
        
        printf("%s", buffer);
    } while ((ret != 0) && (ret != -1));

    printf("\n");
}

void writeHttpResponse(int connfd)
{
    unsigned char str[] = "HTTP/1.1 200 OK\nContent-Type: text/html\n\n<html><h1>Hello World</h1></html>\n";
    
    write(connfd, &str, strlen(str));
    
    printf("HTTP Response: %s", str );
}
/*
 * 
 */
int main(int argc, char** argv) 
{    
    int port = 8080;
    
    printf("Web Server - Using Socket Channel (running in port %d)\n", port);
    
    int listenfd = 0, connfd = 0;
    struct sockaddr_in serv_addr; 
    
    time_t ticks; 
    int ret;

    listenfd = socket(AF_INET, SOCK_STREAM, 0);
    memset(&serv_addr, '0', sizeof(serv_addr));
    
    serv_addr.sin_family = AF_INET;
    serv_addr.sin_addr.s_addr = htonl(INADDR_ANY);
    serv_addr.sin_port = htons(port); 

    ret = bind(listenfd, (struct sockaddr*)&serv_addr, sizeof(serv_addr)); 

    
    if (ret == -1)
    {
        printf("[ERROR] bind failed with error %d\n", errno);
        exit(-1);
    }
    
    ret = listen(listenfd, 10); 
    
    if (ret == -1)
    {
        printf("[ERROR] listen failed with error %d\n", errno);
        exit(-1);
    }
        

    while(1)
    {
        connfd = accept(listenfd, (struct sockaddr*)NULL, NULL); 

        if (connfd == -1)
        {
            printf("[ERROR] accept returned %d\n", errno);
            sleep(1);
            continue;   // try again
        }
        
        struct timeval tv;
        tv.tv_sec = 1;
        tv.tv_usec = 0;
        setsockopt(connfd, SOL_SOCKET, SO_RCVTIMEO, (const char*)&tv, sizeof tv);
        
        ticks = time(NULL);
        
        int v;

        readHttpRequest(connfd);
        writeHttpResponse(connfd);
        
        close(connfd);
        //sleep(1);
     }
    return 0;
}


