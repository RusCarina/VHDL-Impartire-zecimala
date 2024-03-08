library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity uc_principal is
generic(n: natural);
  Port ( 
x: in std_logic_vector(15 downto 0);
y: in std_logic_vector(15 downto 0);
clk: in std_logic;
rst : in std_logic;
selectie: in std_logic_vector(1 downto 0);
sout: out STD_LOGIC_VECTOR(15 downto 0)
  );
end uc_principal;

architecture Behavioral of uc_principal is

component impartireaCuRefacere is
generic(n : natural:= 20);
 Port ( 
 clk: in std_logic;
 rst : in STD_LOGIC;
 start : in STD_LOGIC;
 x : in STD_LOGIC_VECTOR(n-1 downto 0);
 y : in STD_LOGIC_VECTOR(n-1 downto 0);
 a : out STD_LOGIC_VECTOR(n-1 downto 0);
 q : out STD_LOGIC_VECTOR(n-1 downto 0);
 Term : out STD_LOGIC);
end component;

component impartireaFaraRefacere is
generic(n : natural:= 20);
 Port ( 
 clk: in std_logic;
 rst : in STD_LOGIC;
 start : in STD_LOGIC;
 x : in STD_LOGIC_VECTOR(n-1 downto 0);
 y : in STD_LOGIC_VECTOR(n-1 downto 0);
 a : out STD_LOGIC_VECTOR(n-1 downto 0);
 q : out STD_LOGIC_VECTOR(n-1 downto 0);
 Term : out STD_LOGIC);
end component;

signal start, Term1, Term2: std_logic;
signal a1, q1, a2, q2: std_logic_vector(19 downto 0);
signal x_in,y_in: std_logic_vector(19 downto 0):=(others => '0');
signal a1_sout, a2_sout, q1_sout, q2_sout, sel: std_logic_vector(15 downto 0):=(others => '0');

begin

x_in <= "0000" & x;
y_in <= "0000" & y;

impartire1: impartireaCuRefacere port map(clk => clk, rst => rst, start => '1', x => x_in, y => y_in, 
a => a1, q => q1, Term => Term1);

impartire2: impartireaFaraRefacere port map(clk => clk, rst => rst, start => '1', x => x_in, y => y_in, 
a => a2, q => q2, Term => Term2);

a1_sout <= a1(15 downto 0);
a2_sout <= a2(15 downto 0);

q1_sout <= q1(15 downto 0);
q2_sout <= q2(15 downto 0);

process(selectie)
begin
case selectie is
    when "00"=> sel<=a1_sout;
    when "01"=> sel<=q1_sout;
    when "10"=> sel<=a2_sout;
    when others=> sel<=q2_sout;
end case;
end process;
sout <= sel;
end Behavioral;
