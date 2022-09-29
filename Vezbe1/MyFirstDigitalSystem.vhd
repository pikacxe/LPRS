-- Copyright (C) 2020  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and any partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details, at
-- https://fpgasoftware.intel.com/eula.

-- PROGRAM		"Quartus Prime"
-- VERSION		"Version 20.1.1 Build 720 11/11/2020 SJ Lite Edition"
-- CREATED		"Wed Oct 20 13:47:51 2021"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY MyFirstDigitalSystem IS 
	PORT
	(
		iA :  IN  STD_LOGIC;
		iB :  IN  STD_LOGIC;
		oY :  OUT  STD_LOGIC
	);
END MyFirstDigitalSystem;

ARCHITECTURE bdf_type OF MyFirstDigitalSystem IS 

SIGNAL	sS :  STD_LOGIC;


BEGIN 



sS <= iA AND iB;


oY <= NOT(sS);



END bdf_type;