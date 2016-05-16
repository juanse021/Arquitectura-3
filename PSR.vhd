--------------------------------------------------------------------------------
--                       Maria Alejandra Gomez Montoya                        --
--                       Juan Sebastian Herrera Giraldo                       --
--                       Cristhian Andrés Rivera Osorio                       --
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PSR is
    Port ( reset : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           nzvc : in  STD_LOGIC_VECTOR (3 downto 0);
			  ncwp : in  STD_LOGIC;
			  cwp : out  STD_LOGIC;
           psr_out : out  STD_LOGIC);
end PSR;

architecture Behavioral of PSR is

begin

	process(reset,clk, nzvc)
	begin
	
		if (reset = '1') then
			psr_out <= '0';
			cwp <= '0';
		else
			if(rising_edge(clk)) then
				psr_out <= nzvc(0);
				cwp <= ncwp;
			end if;
		end if;
		
	end process;


end Behavioral;

