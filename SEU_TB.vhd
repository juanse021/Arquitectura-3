--------------------------------------------------------------------------------
--                       Maria Alejandra Gomez Montoya                        --
--                       Juan Sebastian Herrera Giraldo                       --
--                       Cristhian Andrés Rivera Osorio                       --
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY SEU_TB IS
END SEU_TB;
 
ARCHITECTURE behavior OF SEU_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT SEU
    PORT(
         imm : IN  std_logic_vector(12 downto 0);
         SEU_out : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;    

   --Inputs
   signal imm : std_logic_vector(12 downto 0) := (others => '0');

 	--Outputs
   signal SEU_out : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: SEU PORT MAP (
          imm => imm,
          SEU_out => SEU_out
        );

   -- Stimulus process
	stim_proc: process
   begin		
	
      imm <= "0100000000000";
      wait for 100 ns;	
		imm <= "1011111111111";
      wait;
		
   end process;

END;