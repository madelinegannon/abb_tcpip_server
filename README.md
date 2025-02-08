# ABB TCP/IP Server
Example for real-time communication with ABB industrial robots.

### Requirements
This example requires the free RobotWare option `PC-Interface 616-1` to be installed. 

### Limitations
This TCP/IP method can only send and receive ~4-5 commands per second. Faster realtime communication (e.g., 250 commands per second), requires use the paid RobotWare option `Externally Guided Motion 689-1`. 

## Running the Example
`Server_TCPIP.mod` demonstrates how an ABB robot can listen for incoming messages from a PC connected via ethernet.

1. Load the module onto the robot or virtual controller.
2. Start the Flex Pendant, open the Production Window, press `PP To Main`, and then press play.
3. Start any client application that sends data to `127.0.0.1:1025` if simulating or `192.128.100.101:1025` when connected to a real robot.

This program shows how to dynamically handle disconnections: you can close and restart the client or server at any time, and `Server_TCPIP.mod` should be able to reconnect without throwing any errors.

![](https://github.com/madelinegannon/abb_tcpip_server/blob/main/assets/server_tcpip_flex_pendant.gif)


### Changing the Robot's IP Address
You can update the `SERVER_IP` address to match your robot's IP address on line 8:

```pascal
LOCAL CONST string SERVER_IP:="192.168.100.101"; ! Change to your robot's IP Address
```
Or you can change your robot's IP address to match the `SERVER_IP` address.
![](https://github.com/madelinegannon/abb_tcpip_server/blob/main/assets/ip_address_settings.png)

