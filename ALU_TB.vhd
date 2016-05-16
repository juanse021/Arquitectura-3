--------------------------------------------------------------------------------
--                       Maria Alejandra Gomez Montoya                        --
--                       Juan Sebastian Herrera Giraldo                       --
--                       Cristhian Andrés Rivera Osorio                       --
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY ALU_TB IS
END ALU_TB;
 
ARCHITECTURE behavior OF ALU_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALU
    PORT(
         ALUOp : IN  std_logic_vector(5 downto 0);
         in1 : IN  std_logic_vector(31 downto 0);
         in2 : IN  std_logic_vector(31 downto 0);
			c : in  STD_LOGIC;
         ALUResult : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
	signal c : STD_LOGIC;
   signal ALUOp : std_logic_vector(5 downto 0) := (others => '0');
   signal in1 : std_logic_vector(31 downto 0) := (others => '0');
   signal in2 : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal ALUResult : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU PORT MAP (
          ALUOp => ALUOp,
          in1 => in1,
          in2 => in2,
			 c => c,
          ALUResult => ALUResult
        );
		  
   -- Stimulus process
   stim_proc: process
   begin			  
	     -- hold reset state for 100 ns.
      wait for 100 ns;	
		
		in1 <= x"0000002A";
		in2 <= x"0000000F";
		c <= '1';
		 
      -- insert stimulus here 
		ALUOp <= "000001";
		wait for 100 ns;
	
		ALUOp <= "000010";
		wait for 100 ns;
		
		ALUOp <= "000011";
		wait for 100 ns;
		
		ALUOp <= "000100";
		wait for 100 ns;
		
		ALUOp <= "000101";
		wait for 100 ns;
		
		ALUOp <= "000110";
		wait for 100 ns;
		
		ALUOp <= "000111";
		wait for 100 ns;
		
		ALUOp <= "001000";		
		wait for 100 ns;
		
		ALUOp <= "001101";
		wait for 100 ns;
		
		ALUOp <= "001011";
		wait;
   end process;

END;