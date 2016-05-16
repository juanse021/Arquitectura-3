--------------------------------------------------------------------------------
--                       Maria Alejandra Gomez Montoya                        --
--                       Juan Sebastian Herrera Giraldo                       --
--                       Cristhian Andrés Rivera Osorio                       --
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY PSR_TB IS
END PSR_TB;
 
ARCHITECTURE behavior OF PSR_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PSR
    PORT(
         reset : IN  std_logic;
         clk : IN  std_logic;
         nzvc : IN  std_logic_vector(3 downto 0);
         psr_out : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal reset : std_logic := '0';
   signal clk : std_logic := '0';
   signal nzvc : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal psr_out : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PSR PORT MAP (
          reset => reset,
          clk => clk,
          nzvc => nzvc,
          psr_out => psr_out
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
    begin		
      reset <= '1';
      wait for 100 ns;	
		reset <= '0'; 
		nzvc <= X"1";       
		wait for 100 ns;
		nzvc <= x"0"; 
      wait;
   end process;

END;
