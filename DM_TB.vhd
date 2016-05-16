--------------------------------------------------------------------------------
--                       Maria Alejandra Gomez Montoya                        --
--                       Juan Sebastian Herrera Giraldo                       --
--                       Cristhian Andrés Rivera Osorio                       --
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY DM_TB IS
END DM_TB;
 
ARCHITECTURE behavior OF DM_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DM
    PORT(
         reset : IN  std_logic;
         WEnable : IN  std_logic;
         Address : IN  std_logic_vector(31 downto 0);
         Data : IN  std_logic_vector(31 downto 0);
         DMout : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal reset : std_logic := '0';
   signal WEnable : std_logic := '0';
   signal Address : std_logic_vector(31 downto 0) := (others => '0');
   signal Data : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal DMout : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DM PORT MAP (
          reset => reset,
          WEnable => WEnable,
          Address => Address,
          Data => Data,
          DMout => DMout
        ); 

   -- Stimulus process
   stim_proc: process
   begin	
      reset <= '1';
		WEnable <= '1';
		Address <= x"00001000";
		Data <= x"00001000";
      wait for 100 ns;	
		reset <= '0'; 
		WEnable <= '1';
		Address <= x"00000005";
		Data <= x"00000007";
		wait for 100 ns;	
		reset <= '0'; 
		WEnable <= '0';
		Address <= x"00000005";
		Data <= x"0000000F";
		wait for 100 ns;	
		reset <= '0'; 
		WEnable <= '1';
		Address <= x"00000005";
		Data <= x"0000000A";
      wait;
   end process;

END;
