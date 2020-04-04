library ieee;
use ieee.std_logic_1164.all;

entity BarrelShifter is
	generic(
		n : integer;
		m : integer
	);
	port(
		clk : in std_logic;
		input : in std_logic_vector(n - 1 downto 0);
		shift : in std_logic_vector(m - 1 downto 0);
		sign_extend : in std_logic;
		right_shift : in std_logic;
		output : out std_logic_vector(n - 1 downto 0)
	);
end BarrelShifter;

architecture Behavioral of BarrelShifter is
	
begin

	main_process: process(clk)
		type intermediate_results is array(0 to m) of std_logic_vector(n - 1 downto 0);
		variable intermediate : intermediate_results;
		variable padding : std_logic;
		variable shift_amount : natural;
	begin
		if rising_edge(clk) then
			padding := right_shift and sign_extend and input(n - 1);
		
			-- Initialize; reverse if we're shifting to the right
			if (right_shift = '1') then
				for i in 0 to n - 1 loop
					intermediate(0)(i) := input(n - i - 1);
				end loop;
			else
				intermediate(0) := input;
			end if;
			
			-- Shift to the left
			shift_amount := 1;
			for i in 0 to m - 1 loop
				if (shift(i) = '1') then
					intermediate(i + 1)(n - 1 downto shift_amount) := intermediate(i)(n - shift_amount - 1 downto 0);
					intermediate(i + 1)(shift_amount - 1 downto 0) := (others => padding);
				else
					intermediate(i + 1) := intermediate(i);
				end if;
				shift_amount := shift_amount * 2;
			end loop;
			
			-- Set output; reverse if we're shifting to the right
			if (right_shift = '1') then
				for i in 0 to n - 1 loop
					output(i) <= intermediate(m)(n - i - 1);
				end loop;
			else
				output <= intermediate(m);
			end if;
			
		end if;
	end process;

end Behavioral;

