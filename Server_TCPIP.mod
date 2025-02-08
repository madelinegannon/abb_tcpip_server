MODULE Server_TCPIP
    VAR socketdev server_socket;
    VAR socketdev client_socket;
    VAR string client_ip;
    VAR string received_string;

    ! IP Address and port of robot
    LOCAL CONST string SERVER_IP:="192.168.100.101";
    LOCAL CONST num PORT:=1025;

    PROC main()
        RestartServer;
        WHILE TRUE DO
            ReceiveCommand;
        ENDWHILE
    ERROR
        IF ERRNO=ERR_SOCK_CLOSED THEN
            TPWrite "Client Socket Closed.";
            RestartServer;
        ENDIF
    ENDPROC

    PROC ReceiveCommand()
        SocketReceive client_socket\Str:=received_string;
        TPWrite "Client wrote: "+received_string;
        SocketSend client_socket\Str:="Hello from server!";
    ERROR
        IF ERRNO=ERR_SOCK_CLOSED THEN
            TPWrite "Socket Closed. Restarting Server";
            RestartServer;
            RETRY;
        ENDIF
    ENDPROC

    PROC RestartServer()
        TPWrite " ";
        SocketClose server_socket;
        SocketClose client_socket;
        SocketCreate server_socket;
        IF RobOS() THEN
            ! If connected to the real controller 
            SocketBind server_socket,SERVER_IP,PORT;
        ELSE
            ! If connected to the virtual controller
            SocketBind server_socket,"127.0.0.1",PORT;
        ENDIF
        SocketListen server_socket;
        TPWrite "Waiting for connection...";
        SocketAccept server_socket,client_socket\ClientAddress:=client_ip,\Time:=WAIT_MAX;
        TPWrite "Connected to client: "+client_ip;
        TPWrite "Listening to TCP/IP commands...";
    ERROR
        IF ERRNO=ERR_SOCK_TIMEOUT THEN
            RETRY;
        ELSEIF ERRNO=ERR_SOCK_CLOSED THEN
            RETURN ;
        ELSE
            ! No error recovery handling
            TPWrite "Socket Error...Cannot Recover.";
        ENDIF
    ENDPROC

ENDMODULE
