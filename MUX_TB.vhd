--------------------------------------------------------------------------------
--                       Maria Alejandra Gomez Montoya                        --
--                       Juan Sebastian Herrera Giraldo                       --
--                       Cristhian Andrés Rivera Osorio                       --
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY MUX_TB IS
END MUX_TB;
 
ARCHITECTURE behavior OF MUX_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MUX
    PORT(
         entrada1 : IN  std_logic_vector(31 downto 0);
         entrada2 : IN  std_logic_vector(31 downto 0);
         MUX_out : OUT  std_logic_vector(31 downto 0);
         i : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal entrada1 : std_logic_vector(31 downto 0) := (others => '0');
   signal entrada2 : std_logic_vector(31 downto 0) := (others => '0');
   signal i : std_logic := '0';

 	--Outputs
   signal MUX_out : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MUX PORT MAP (
          entrada1 => entrada1,
          entrada2 => entrada2,
          MUX_out => MUX_out,
          i => i
        ); 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		entrada1 <= x"00031201";
		entrada2 <= x"0120020A";
		i <= '0';
      wait for 100 ns;	
		i <= '1';

      wait;
   end process;

END;
