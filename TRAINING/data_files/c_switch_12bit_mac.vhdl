-- $Id: c_switch_12bit_mac.vhdl 454 2010-03-16 22:18:01Z curley $
-- $URL: file:///afs/awd/projects/eclipz/13s/libs/clib/.svnDB/c01/releases/c1_c021/vhdl/c_switch_12bit_mac.vhdl $
-- *!**************************************************************************
-- *! (C) Copyright International Business Machines Corp. 2007
-- *!           All Rights Reserved -- Property of IBM
-- *!                   *** IBM Confidential ***
-- *!**************************************************************************
-- *! FILENAME    : c_switch_12bit_mac.vhdl
-- *! TITLE       :
-- *! DESCRIPTION :
-- *!
-- *! OWNER  NAME : Panchalam Ramanujan          EMAIL : pramanu@us.ibm.com
-- *! BACKUP NAME : Charlie Hwang                EMAIL : clhwang@us.ibm.com
-- *! BACKUP NAME : Aditya Khargonekar           EMAIL : akhargon@us.ibm.com
-- *!**************************************************************************
--
-- HISTORY
-------------------------------------------------------------------------------
-- VERSION | OWNER     |  DATE  | COMMENT
-------------------------------------------------------------------------------
--   1.0   | clhwang   |08/13/07| Initial version
--   1.1   | akhargon  |09/07/07| Attribute updates for vcs, vwl
--   1.2   | clhwang   |12/13/07| Add global disable pin
--   1.3   | clhwang   |01/16/08| Add pin power domain attributes
--   1.4   | clhwang   |01/30/08| Fix vwl sourceless issue
--   1.5   | akhargon  |02/12/08| Added internal probe points
--   1.6   | pramanu   |01/13/09| (No Changes updating to current pdd2)
-------------------------------------------------------------------------------

library clib, ibm, ieee, latches, stdcell, support;
 use ibm.std_ulogic_function_support.all;
 use ibm.std_ulogic_support.all;
 use ibm.std_ulogic_unsigned.all;
 use ibm.synthesis_support.all;
 use ibm.texsim.all;
 use ibm.texsim_ATTRIBUTEs.all;
 use ieee.std_logic_1164.all;
 use support.logic_support_pkg.all;
 use support.power_logic_pkg.all;
 use support.signal_resolution_pkg.all;

Entity  c_switch_12bit_mac IS
  PORT (
     -- power pins
        vcs                             : INOUT power_logic;
        vdin                             : INOUT power_logic;
        vdout                            : INOUT power_logic;
        gnd                             : INOUT power_logic;

     -- Configuration -- DC control
        enable                            : IN  std_ulogic_vector(0 to 11);
        enable_out                            : OUT  std_ulogic_vector(0 to 11)
);

  ATTRIBUTE POWER_PIN of vcs : signal is 1;
  ATTRIBUTE POWER_PIN of vdin : signal is 1;
  ATTRIBUTE POWER_PIN of vdout : signal is 1;
  ATTRIBUTE PIN_DEFAULT_POWER_DOMAIN of c_switch_12bit_mac : entity is "vcs";
  ATTRIBUTE GROUND_PIN of gnd : signal is 1;
  ATTRIBUTE PIN_DEFAULT_GROUND_DOMAIN of c_switch_12bit_mac : entity is "gnd";

  ATTRIBUTE BLOCK_TYPE of c_switch_12bit_mac : entity is custom;
  ATTRIBUTE RECURSIVE_SYNTHESIS OF c_switch_12bit_mac : entity IS 0;
  ATTRIBUTE BTR_NAME of c_switch_12bit_mac : entity is "c_switch_12bit_mac";

End c_switch_12bit_mac ;

architecture c_switch_12bit_mac of c_switch_12bit_mac is

-- Register signal declarations

-- *********************************************************************************
-- Signals
-- *********************************************************************************

-- Unused Vector
  SIGNAL enable_int                                      : std_ulogic_vector(0 to 11) ;


BEGIN

--     ______________________________________________________________________
--   /_____________________________________________________________________ /|
--   |                pass thru control signals
--   |_____________________________________________________________________|/
enable_int <= enable;
enable_out       <= enable_int;


--     ______________________________________________________________________
--   /_____________________________________________________________________ /|
--   |                powergating function                                 | |
--   |_____________________________________________________________________|/


vdout <= vdin WHEN enable_int(0 to 11) = "111111111111" ELSE '0';

end c_switch_12bit_mac ;

