library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sumator_16biti is
  Port (
    X : in STD_LOGIC_VECTOR (19 downto 0);
    Y : in STD_LOGIC_VECTOR (19 downto 0);
    Cin : in STD_LOGIC;
    S : out STD_LOGIC_VECTOR (19 downto 0);
    Cout : out STD_LOGIC
  );
end sumator_16biti;

architecture Behavioral of sumator_16biti is
  signal carry: std_logic_vector(4 downto 0) := "00000";
  signal sum : std_logic_vector(19 downto 0) := x"00000";

  component SumatorZecimal is
    Port (
      X : in STD_LOGIC_VECTOR (3 downto 0);
      Y : in STD_LOGIC_VECTOR (3 downto 0);
      Cin : in STD_LOGIC;
      S : out STD_LOGIC_VECTOR (3 downto 0);
      Cout : out STD_LOGIC
    );
  end component;

begin
  dut1: SumatorZecimal port map(
    X => X(3 downto 0),
    Y => Y(3 downto 0),
    Cin => Cin,
    S => sum(3 downto 0),
    Cout => carry(0)
  );

  dut2: SumatorZecimal port map(
    X => X(7 downto 4),
    Y => Y(7 downto 4),
    Cin => carry(0),
    S => sum(7 downto 4),
    Cout => carry(1)
  );

  dut3: SumatorZecimal port map(
    X => X(11 downto 8),
    Y => Y(11 downto 8),
    Cin => carry(1),
    S => sum(11 downto 8),
    Cout => carry(2)
  );

  dut4: SumatorZecimal port map(
    X => X(15 downto 12),
    Y => Y(15 downto 12),
    Cin => carry(2),
    S => sum(15 downto 12),
    Cout => carry(3)
  );

--gestionare bit transport
  dut5: SumatorZecimal port map(
    X => X(19 downto 16),
    Y => Y(19 downto 16),
    Cin => carry(3),
    S => sum(19 downto 16),
    Cout => carry(4)
  );

  S <= sum;
  Cout <= carry(4);

end Behavioral;
