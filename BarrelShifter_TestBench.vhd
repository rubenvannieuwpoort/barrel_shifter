library ieee;
use ieee.std_logic_1164.all;
 
entity BarrelShifter_TestBench is
end BarrelShifter_TestBench;
 
architecture behavior of BarrelShifter_TestBench is
	component BarrelShifter
		generic(
			n : natural;
			m : natural
		);
		port(
			clk : in std_logic;
			input : in std_logic_vector(n - 1 downto 0);
			shift : in std_logic_vector(m - 1 downto 0);
			sign_extend : in std_logic;
			right_shift : in std_logic;
			output : out std_logic_vector(n - 1 downto 0)
		);
	end component;

   --Inputs
   signal input : std_logic_vector(7 downto 0) := "10110100";
   signal shift : std_logic_vector(2 downto 0) := (others => '0');
   signal sign_extend : std_logic := '1';
   signal right_shift : std_logic := '1';

 	--Outputs
   signal output : std_logic_vector(7 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
	signal clk : std_logic;
   constant clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: BarrelShifter
	generic map(
		n => 8,
		m => 3
	)
	port map(
		clk => clk,
		input => input,
		shift => shift,
		sign_extend => sign_extend,
		right_shift => right_shift,
		output => output
	);

   -- Clock process definitions
   clock_process :process
   begin
		clk <= '0';
		wait for clock_period/2;
		clk <= '1';
		wait for clock_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;
		shift <= "001";
      wait for clock_period*3;
		shift <= "010";
      wait for clock_period*3;
		shift <= "011";
      wait for clock_period*3;
		shift <= "100";
      wait for clock_period*3;
		shift <= "101";
      wait for clock_period*3;
		shift <= "110";
      wait for clock_period*3;
		shift <= "111";
      wait for clock_period*3;
		
      -- insert stimulus here 

      wait;
   end process;

END;
