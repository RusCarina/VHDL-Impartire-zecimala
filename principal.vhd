library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity principal is
  Port (
   clk : in STD_LOGIC;
   rst : in std_logic;
   number : in STD_LOGIC_VECTOR (15 downto 0);
   an : out STD_LOGIC_VECTOR (3 downto 0);
   selectie: in std_logic_vector(1 downto 0);
   cat : out STD_LOGIC_VECTOR (6 downto 0)
  );
end principal;

architecture Behavioral of principal is

signal x: std_logic_vector(15 downto 0):=(others => '0');
signal y: std_logic_vector(15 downto 0):=(others => '0');
signal enable: std_logic;
signal iesire: std_logic_vector(15 downto 0);

component MPG is
    Port ( input : in STD_LOGIC;
           clk : in STD_LOGIC;
           enable : out STD_LOGIC
           );
end component;

component SSD is
    Port ( clk : in STD_LOGIC;
           number : in STD_LOGIC_VECTOR (15 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0);
           cat : out STD_LOGIC_VECTOR (6 downto 0)
           );
end component;

component uc_principal is
generic(n: natural);
  Port (
  x: in std_logic_vector(15 downto 0);
  y: in std_logic_vector(15 downto 0);
  clk: in std_logic;
  rst : in std_logic;
  selectie: in std_logic_vector(1 downto 0);
  sout: out STD_LOGIC_VECTOR(15 downto 0)
  );
end component;

begin

x(3 downto 0) <= x"3";
x(7 downto 4) <= x"6";
x(11 downto 8) <= x"0";
x(15 downto 12) <= x"0";

y(3 downto 0) <= x"7";
y(7 downto 4) <= x"1";
y(11 downto 8) <= x"0";
y(15 downto 12) <= x"0";

uc: uc_principal generic map (n => 20) port map (x,y,clk, rst, selectie,iesire);
display: SSD port map(clk, iesire, an, cat);
monopulse: MPG port map('1', clk, enable);

end Behavioral;
