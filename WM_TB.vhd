--------------------------------------------------------------------------------
--                       Maria Alejandra Gomez Montoya                        --
--                       Juan Sebastian Herrera Giraldo                       --
--                       Cristhian Andrés Rivera Osorio                       --
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY WM_TB IS
END WM_TB;
 
ARCHITECTURE behavior OF WM_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT WM
    PORT(
         Op : IN  std_logic_vector(1 downto 0);
         Op3 : IN  std_logic_vector(5 downto 0);
         rs1 : IN  std_logic_vector(4 downto 0);
         rs2 : IN  std_logic_vector(4 downto 0);
         rd : IN  std_logic_vector(4 downto 0);
         cwp : IN  std_logic;
         nrs1 : OUT  std_logic_vector(5 downto 0);
         nrs2 : OUT  std_logic_vector(5 downto 0);
         nrd : OUT  std_logic_vector(5 downto 0);
         ncwp : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Op : std_logic_vector(1 downto 0) := (others => '0');
   signal Op3 : std_logic_vector(5 downto 0) := (others => '0');
   signal rs1 : std_logic_vector(4 downto 0) := (others => '0');
   signal rs2 : std_logic_vector(4 downto 0) := (others => '0');
   signal rd : std_logic_vector(4 downto 0) := (others => '0');
   signal cwp : std_logic := '0';

 	--Outputs
   signal nrs1 : std_logic_vector(5 downto 0);
   signal nrs2 : std_logic_vector(5 downto 0);
   signal nrd : std_logic_vector(5 downto 0);
   signal ncwp : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: WM PORT MAP (
          Op => Op,
          Op3 => Op3,
          rs1 => rs1,
          rs2 => rs2,
          rd => rd,
          cwp => cwp,
          nrs1 => nrs1,
          nrs2 => nrs2,
          nrd => nrd,
          ncwp => ncwp
        ); 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		cwp <= '0';
		Op <= "10";
		Op3 <= "111101";
		rs1 <= "00100";
		rs2 <= "01110";
		rd <= "11100";		
      wait for 100 ns;	
		cwp <= '0';
		Op <= "10";
		Op3 <= "111100";
		rs1 <= "00100";
		rs2 <= "01110";
		rd <= "11100";
		wait for 100 ns;	
		cwp <= '1';
		Op <= "10";
		Op3 <= "111101";
		rs1 <= "00100";
		rs2 <= "01110";
		rd <= "11100";
      -- insert stimulus here 

      wait;
   end process;

END;
