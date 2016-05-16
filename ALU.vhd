--------------------------------------------------------------------------------
--                       Maria Alejandra Gomez Montoya                        --
--                       Juan Sebastian Herrera Giraldo                       --
--                       Cristhian Andrés Rivera Osorio                       --
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ALU is
    Port ( c : in  STD_LOGIC;
			  ALUOp : in  STD_LOGIC_VECTOR (5 downto 0);
           in1 : in  STD_LOGIC_VECTOR (31 downto 0);
           in2 : in  STD_LOGIC_VECTOR (31 downto 0);
           ALUResult : out  STD_LOGIC_VECTOR (31 downto 0));
end ALU;

architecture Behavioral of ALU is

begin
	process(in1,in2,ALUOp,c)
	begin
		if (ALUOp = "000001") or (ALUOp = "001001") then      -- Add or Addcc
			ALUResult <= in1 + in2;
		elsif (ALUOp = "000010") or (ALUOp = "001100") then   -- Sub or Subcc
			ALUResult <= in1 - in2;			
		elsif (ALUOp = "000011") or (ALUOp = "001111") then	-- And or Andcc 
			ALUResult <= in1 and in2;		
		elsif (ALUOp = "000100") or (ALUOp = "010000") then	-- Nand or Nandcc
			ALUResult <= in1 nand in2;			
		elsif (ALUOp = "000101") or (ALUOp = "010001") then	-- Or or Orcc 
			ALUResult <= in1 or in2;
		elsif (ALUOp = "000110") or (ALUOp = "010010") then	-- Nor or Norcc 
			ALUResult <= in1 nor in2;
		elsif (ALUOp = "000111") or (ALUOp = "010010") then	-- Xor or Xorcc
			ALUResult <= in1 xor in2;
		elsif (ALUOp = "001000") or (ALUOp = "010100") then	-- Xnor or Xnorcc
			ALUResult <= in1 xnor in2;
		elsif (ALUOp = "001010") or (ALUOp = "001011") then	-- Addx or Addxcc
			ALUResult <= in1 + in2 + c;
		elsif (ALUOp = "001101") or (ALUOp = "001110") then	-- Subx or Subxcc
			ALUResult <= in1 - in2 - c;
		else ALUResult <= (others=>'0');
		end if;
	end process;

end Behavioral;