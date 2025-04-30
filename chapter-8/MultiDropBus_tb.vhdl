library IEEE;
use IEEE.std_logic_1164.all;

entity MultiDropBus_tb is
end entity;

architecture behavior of MultiDropBus_tb is

  -- Komponen yang diuji (UUT)
  component MultiDropBus
    port (
      Clock, Reset     : in std_logic;
      Data_Bus         : in std_logic_vector(7 downto 0);
      A_EN, B_EN, C_EN : in std_logic;
      A, B, C          : out std_logic_vector(7 downto 0)
    );
  end component;

  -- Sinyal uji
  signal Clock   : std_logic := '0';
  signal Reset   : std_logic := '1';
  signal Data_Bus : std_logic_vector(7 downto 0) := (others => '0');
  signal A_EN, B_EN, C_EN : std_logic := '0';
  signal A, B, C : std_logic_vector(7 downto 0);

  constant clk_period : time := 10 ns;

begin

  -- Instansiasi UUT
  uut: MultiDropBus
    port map (
      Clock   => Clock,
      Reset   => Reset,
      Data_Bus => Data_Bus,
      A_EN    => A_EN,
      B_EN    => B_EN,
      C_EN    => C_EN,
      A       => A,
      B       => B,
      C       => C
    );

  -- Clock generator
  clk_process : process
  begin
    while true loop
      Clock <= '0';
      wait for clk_period / 2;
      Clock <= '1';
      wait for clk_period / 2;
    end loop;
  end process;

  -- Stimulus process
  stim_proc : process
  begin
    -- Reset aktif
    Reset <= '0';
    wait for 15 ns;
    Reset <= '1';

    -- Uji register A
    Data_Bus <= x"11";
    A_EN <= '1'; B_EN <= '0'; C_EN <= '0';
    wait for clk_period;

    A_EN <= '0';
    wait for clk_period;

    -- Uji register B
    Data_Bus <= x"22";
    B_EN <= '1';
    wait for clk_period;

    B_EN <= '0';
    wait for clk_period;

    -- Uji register C
    Data_Bus <= x"33";
    C_EN <= '1';
    wait for clk_period;

    C_EN <= '0';
    wait for clk_period;

    -- Akhiri simulasi
    wait;
  end process;

end architecture;
