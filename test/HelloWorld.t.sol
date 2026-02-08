// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.28;

import {Test} from "forge-std/Test.sol";
import {HelloWorld} from "../src/HelloWorld.sol";

contract HelloWorldTest is Test {
    HelloWorld helloWorld;
    string constant INITIAL = "Hello, world";

    //körs inför varje test, precis som en beforeEach i javascript
    function setUp() public {
        helloWorld = new HelloWorld(INITIAL);
    }
    /*---------------DEPLOYMENT----------*/
    
    function test_Deployment_SetsInitialMessage() public view {
        assertEq(helloWorld.message(),INITIAL);
    }

    /*---------------MESSAGE UPDATE----------*/
    function test_UpdateMessage() public {
        string memory newMessage = "BCU25D";

        assertEq(helloWorld.message(), INITIAL);

        helloWorld.setMessage(newMessage);

        assertEq(helloWorld.message(), newMessage);
    }

    function test_AllowMultipleUpdates() public {
        string memory firstMessage = "this i the first message";
        string memory secondMessage = "this is the second message";

        assertEq(helloWorld.message(), INITIAL);

        helloWorld.setMessage(firstMessage);
        assertEq(helloWorld.message(), firstMessage);

        helloWorld.setMessage(secondMessage);
        assertEq(helloWorld.message(), secondMessage);


    }

    /*---------------Retrieve Message----------*/
    function test_RetrieveMessage() public {
        assertEq(helloWorld.getMessage(), INITIAL);

        string memory newMessage = "forge test is awsome!";
        helloWorld.setMessage(newMessage);

        assertEq(helloWorld.getMessage(), newMessage);

    }

}