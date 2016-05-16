--------------------------------------------------------------------------------
--                       Maria Alejandra Gomez Montoya                        --
--                       Juan Sebastian Herrera Giraldo                       --
--                       Cristhian Andrés Rivera Osorio                       --
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Procesador is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           salida : out  STD_LOGIC_VECTOR (31 downto 0));
end Procesador;

architecture Behavioral of Procesador is

	COMPONENT nPC
	PORT(
		nPC_in : IN std_logic_vector(31 downto 0);
		reset : IN std_logic;
		clk : IN std_logic;          
		nPC_out : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	COMPONENT PC
	PORT(
		PC_in : IN std_logic_vector(31 downto 0);
		reset : IN std_logic;
		clk : IN std_logic;          
		PC_out : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	COMPONENT suma
	PORT(
		op1 : IN std_logic_vector(31 downto 0);
		op2 : IN std_logic_vector(31 downto 0);          
		suma_out : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	COMPONENT IM
	PORT(
		IM_in : IN std_logic_vector(31 downto 0);
		reset : IN std_logic;        
		IM_out : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT CU
	PORT(
		Op : IN std_logic_vector(1 downto 0);
		Op2 : IN std_logic_vector(2 downto 0);
		Op3 : IN std_logic_vector(5 downto 0);
		cond : IN std_logic_vector(3 downto 0);
		icc : IN std_logic_vector(3 downto 0);          
		CU_out : OUT std_logic_vector(5 downto 0);
		RFSOURCE : OUT std_logic_vector(1 downto 0);
		PCSOURCE : OUT std_logic_vector(1 downto 0);
		wrEnRF : OUT std_logic;
		wrEnMe : OUT std_logic;
		rfDest : OUT std_logic
		);
	END COMPONENT;
	
	COMPONENT RF
	PORT(
		rs1 : IN std_logic_vector(5 downto 0);
		rs2 : IN std_logic_vector(5 downto 0);
		rd : IN std_logic_vector(5 downto 0);
		reset : IN std_logic;
		datawrite : IN std_logic_vector(31 downto 0);
		writeEnable : IN std_logic;          
		CRs1 : OUT std_logic_vector(31 downto 0);
		CRs2 : OUT std_logic_vector(31 downto 0);
		CRD : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	COMPONENT ALU
	PORT(
		c : IN std_logic;
		in1 : IN std_logic_vector(31 downto 0);
		in2 : IN std_logic_vector(31 downto 0);
		ALUOp : IN std_logic_vector(5 downto 0);
		ALUResult : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT SEU
	PORT(
		imm : IN std_logic_vector(12 downto 0);          
		SEU_out : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	COMPONENT MUX
	PORT(
		entrada1 : IN std_logic_vector(31 downto 0);
		entrada2 : IN std_logic_vector(31 downto 0);
		i : IN std_logic;          
		MUX_out : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT PSRM
	PORT(
		reset : IN std_logic;
		Op1 : IN std_logic;
		Op2 : IN std_logic;
		Aluresult : IN std_logic_vector(31 downto 0);
		Aluop : IN std_logic_vector(5 downto 0);          
		nzvc : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;
	
	COMPONENT PSR
	PORT(
		reset : IN std_logic;
		clk : IN std_logic;
		nzvc : IN std_logic_vector(3 downto 0);
		ncwp : IN std_logic;          
		icc : OUT std_logic_vector(3 downto 0);
		cwp : OUT std_logic;
		psr_out : OUT std_logic
		);
	END COMPONENT;
	
	COMPONENT WM
	PORT(
		Op : IN std_logic_vector(1 downto 0);
		Op3 : IN std_logic_vector(5 downto 0);
		rs1 : IN std_logic_vector(4 downto 0);
		rs2 : IN std_logic_vector(4 downto 0);
		rd : IN std_logic_vector(4 downto 0);
		cwp : IN std_logic;          
		nrs1 : OUT std_logic_vector(5 downto 0);
		nrs2 : OUT std_logic_vector(5 downto 0);
		nrd : OUT std_logic_vector(5 downto 0);
		ncwp : OUT std_logic;
		registroO7 : OUT std_logic_vector(5 downto 0)
		);
	END COMPONENT;
	
	COMPONENT MUXRF
	PORT(
		entrada1 : IN std_logic_vector(5 downto 0);
		entrada2 : IN std_logic_vector(5 downto 0);
		i : IN std_logic;          
		MUXRF_out : OUT std_logic_vector(5 downto 0)
		);
	END COMPONENT;
	
	COMPONENT DM
	PORT(
		reset : IN std_logic;
		WEnable : IN std_logic;
		Address : IN std_logic_vector(31 downto 0);
		Data : IN std_logic_vector(31 downto 0);          
		DMout : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT MUXDM
	PORT(
		entrada1 : IN std_logic_vector(31 downto 0);
		entrada2 : IN std_logic_vector(31 downto 0);
		entrada3 : IN std_logic_vector(31 downto 0);
		i : IN std_logic_vector(1 downto 0);          
		MUXDM_out : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT SEU22
	PORT(
		imm22 : IN std_logic_vector(21 downto 0);          
		SEU22_out : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT SEU30
	PORT(
		imm30 : IN std_logic_vector(29 downto 0);          
		SEU30_out : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT MUXPC
	PORT(
		entrada1 : IN std_logic_vector(31 downto 0);
		entrada2 : IN std_logic_vector(31 downto 0);
		entrada3 : IN std_logic_vector(31 downto 0);
		entrada4 : IN std_logic_vector(31 downto 0);
		i : IN std_logic_vector(1 downto 0);          
		MUXPC_out : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	signal CRD, suma_out, nPC_out, PC_out, IM_out, CRs1, CRs2, ALUResult, MUX_out : std_logic_vector(31 downto 0);
	signal MUXPC_out, suma30_out, suma22_out, SEU30_out, SEU22_out, SEU_out, MUXDM_out, DMout : std_logic_vector(31 downto 0);
	signal MUXRF_out, registroO7, CU_out, nrs1, nrs2, nrd : std_logic_vector(5 downto 0);
	signal icc, nzvc : std_logic_vector(3 downto 0);
	signal PCSOURCE, RFSOURCE : std_logic_vector(1 downto 0);
	signal rfDest, wrEnMe, wrEnRF, psr_out, ncwp, cwp: std_logic;
	
begin
	
	Inst_MUXPC: MUXPC PORT MAP(
		entrada1 => suma30_out,
		entrada2 => suma22_out,
		entrada3 => suma_out,
		entrada4 => ALUResult,
		MUXPC_out => MUXPC_out,
		i => PCSOURCE
	);
	
	Inst_suma22: suma PORT MAP(
		op1 => SEU22_out,
		op2 => PC_out,
		suma_out => suma22_out
	);
	
	Inst_suma30: suma PORT MAP(
		op1 => SEU30_out,
		op2 => PC_out,
		suma_out => suma30_out
	);
	
	Inst_SEU30: SEU30 PORT MAP(
		imm30 => IM_out(29 downto 0),
		SEU30_out => SEU30_out
	);
	
	Inst_SEU22: SEU22 PORT MAP(
		imm22 => IM_out(21 downto 0),
		SEU22_out => SEU22_out
	);
	
	Inst_MUXDM: MUXDM PORT MAP(
		entrada1 => DMout,
		entrada2 => ALUResult,
		entrada3 => PC_out,
		MUXDM_out => MUXDM_out,
		i => RFSOURCE 
	);
	
	Inst_DM: DM PORT MAP(
		reset => reset,
		WEnable => wrEnMe,
		Address => CRD,
		Data => ALUResult,
		DMout => DMout
	);
	
	Inst_WM: WM PORT MAP(
		Op => IM_out(31 downto 30),
		Op3 => IM_out(24 downto 19),
		rs1 => IM_out(18 downto 14),
		rs2 => IM_out(4 downto 0),
		rd => IM_out(29 downto 25),
		cwp => cwp,
		nrs1 => nrs1,
		nrs2 => nrs2,
		nrd => nrd,
		ncwp => ncwp,
		registroO7 => registroO7
	);
	
	Inst_MUXRF: MUXRF PORT MAP(
		entrada1 => nrd,
		entrada2 => registroO7,
		MUXRF_out => MUXRF_out,
		i => rfDest
	);
	
	Inst_nPC: nPC PORT MAP(
		nPC_in => MUXPC_out,
		reset => reset,
		clk => clk,
		nPC_out => nPC_out
	);
	
	Inst_PC: PC PORT MAP(
		PC_in => nPC_out,
		reset => reset,
		clk => clk,
		PC_out => PC_out 
	);
	
	Inst_suma: suma PORT MAP(
		op1 => x"00000001",
		op2 => nPC_out,
		suma_out => suma_out
	);
	
	Inst_IM: IM PORT MAP(
		IM_in => PC_out,
		reset => reset,
		IM_out => IM_out
	);
	
	Inst_CU: CU PORT MAP(
		Op => IM_out(31 downto 30),
		Op2 => IM_out(24 downto 22),
		Op3 => IM_out(24 downto 19),
		cond => IM_out(28 downto 25),
		icc => icc,
		CU_out => CU_out,
		RFSOURCE => RFSOURCE,
		PCSOURCE => PCSOURCE,
		wrEnRF => wrEnRF,
		wrEnMe => wrEnMe,
		rfDest => rfDest
	);
	
	Inst_RF: RF PORT MAP(
		reset => reset,
		rs1 => nrs1,
		rs2 => nrs2,
		rd => MUXRF_out,
		datawrite => MUXDM_out,
		writeEnable => wrEnRF,
		CRs1 => CRs1,
		CRs2 => CRs2,
		CRD => CRD
	);
	
	Inst_SEU: SEU PORT MAP(
		imm => IM_out(12 downto 0),
		SEU_out => SEU_out
	);
	
	Inst_MUX: MUX PORT MAP(
		entrada1 => CRs2,
		entrada2 => SEU_out,
		MUX_out => MUX_out,
		i => IM_out(13) 
	);	
	
	Inst_ALU: ALU PORT MAP(
		c => psr_out,
		in1 => CRs1,
		in2 => MUX_out,
		ALUOp => CU_out,
		ALUResult => ALUResult
	);
	
	Inst_PSRM: PSRM PORT MAP(
		Op1 => CRs1(31),
		Op2 => MUX_out(31),
		Aluresult => ALUResult,
		Aluop => CU_out,
		reset => reset,
		nzvc => nzvc
	);

	Inst_PSR: PSR PORT MAP(
		reset => reset,
		clk => clk,
		ncwp => ncwp,
		cwp => cwp,
		icc => icc,
		nzvc => nzvc,
		psr_out => psr_out
	);
	
	salida <= MUXDM_out;

end Behavioral;