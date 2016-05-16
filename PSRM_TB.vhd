--------------------------------------------------------------------------------
--                       Maria Alejandra Gomez Montoya                        --
--                       Juan Sebastian Herrera Giraldo                       --
--                       Cristhian Andrés Rivera Osorio                       --
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY PSRM_TB IS
END PSRM_TB;
 

ARCHITECTURE behavior OF PSRM_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PSRM
    PORT(
         Op1 : IN  std_logic;
         Op2 : IN  std_logic;
         Aluresult : IN  std_logic_vector(31 downto 0);
         Aluop : IN  std_logic_vector(5 downto 0);
         nzvc : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Op1 : std_logic := '0';
   signal Op2 : std_logic := '0';
   signal Aluresult : std_logic_vector(31 downto 0) := (others => '0');
   signal Aluop : std_logic_vector(5 downto 0) := (others => '0');

 	--Outputs
   signal nzvc : std_logic_vector(3 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PSRM PORT MAP (
          Op1 => Op1,
          Op2 => Op2,
          Aluresult => Aluresult,
          Aluop => Aluop,
          nzvc => nzvc
        ); 

   -- Stimulus process
   stim_proc: process
   begin				
      -- hold reset state for 100 ns.
		Aluresult <= x"00000000";
		Op1 <= '1';
 		Op2 <= '1';
		Aluop <= "001001";
      wait for 100 ns;	
		Aluresult <= x"0000000F";
		Op1 <= '1';
 		Op2 <= '0';
		Aluop <= "001100";
		wait for 100 ns;
		Aluresult <= x"F000010F";
		Op1 <= '0';
 		Op2 <= '1';
		Aluop <= "001011";
		wait for 100 ns;
		Aluresult <= x"F0000000";
		Op1 <= '0';
 		Op2 <= '0';
		Aluop <= "010001";
      wait;
   end process;

END;
