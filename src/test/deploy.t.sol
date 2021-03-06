// Copyright (C) 2019 lucasvo

// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.

pragma solidity >=0.4.23;

import "ds-test/test.sol";

import "../deploy.sol";
import "../budget.sol";
import "../medallion.sol";

contract DeployTest is DSTest  {
    address self;
    
    function setUp() public {
        self = address(this);
    }

    function testDeploy() public logs_gas {
        MedallionFab depl = new MedallionFab(100, self);
        Medallion mdln = Medallion(depl.mdln());
        Budget bags = Budget(depl.bags());
        
        bags.budget(self, 10);
        bags.mint(self, 10);
        assertEq(mdln.balanceOf(self), 10);
        assertEq(mdln.totalSupply(), 10);
    }

    function testFailDeploy() public logs_gas {
        MedallionFab depl = new MedallionFab(100, self);
        Budget bags = Budget(depl.bags());
        
        bags.budget(self, 10);
        bags.mint(self, 20);
    }
}
