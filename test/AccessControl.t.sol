// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {AccessControl} from "../src/AccessControl.sol";

contract AccessControlTest is Test {
    event RoleAssigned(address indexed account, string role);
    AccessControl accessControl;

    address owner = vm.addr(0x1);
    address admin = vm.addr(0x2);
    address supporter = vm.addr(0x3);
    address member = vm.addr(0x4);

    function setUp() public {
        vm.prank(owner);
        accessControl = new AccessControl();
    }

    /*-------------------DEPLOYMENT-------------- */
    function test_Deployment() public view {
        //owner should be admin
        //mapping admins should have owner set to true
        assertTrue(accessControl.admins(owner));
    }

    /*-------------------ASSIGN ROLE TEST-------------- */
    function test_AssignAdminRole() public {
        assertFalse(accessControl.admins(admin));

        vm.expectEmit(true, false, false, true);

        emit RoleAssigned(admin, "Admin");

        vm.prank(owner);
        accessControl.assignAdminRole(admin);

        assertTrue(accessControl.admins(admin));
    }

    function test_AssignSupRole() public {
        assertFalse(accessControl.supporters(supporter));
        vm.expectEmit(true, false, false, true);

        emit RoleAssigned(supporter, "Supporter");
        vm.prank(owner);
        accessControl.assignOtherRole(supporter, "Supporter");

        assertTrue(accessControl.supporters(supporter));
    }

    function test_AssignMemRole() public {
        assertFalse(accessControl.members(member));
        vm.expectEmit(true, false, false, true);

        emit RoleAssigned(member, "Member");
        vm.prank(owner);
        accessControl.assignOtherRole(member, "Member");

        assertTrue(accessControl.members(member));
    }

    function test_RevertInvalidRole() public {
        vm.prank(owner);
        vm.expectRevert(bytes("Invalid role. Please try again!"));
        accessControl.assignOtherRole(member, "Invalid Role");
    }

    function test_RevertNotOwner() public {
        vm.prank(supporter);
        vm.expectRevert(bytes("You are not an admin and cannot call this function!"));
        accessControl.assignOtherRole(member, "Member");
    }
}
