library IEEE;
use IEEE.std_logic_1164.all;

entity reg_tb is
end entity;

architecture behavior of reg_tb is

  -- Komponen yang akan diuji (Unit Under Test)
  component reg
    port (
      Clock   : in  std_logic;
      Reset   : in  std_logic;
      Reg_In  : in  std_logic_vector(7 downto 0);
      EN      : in  std_logic;
      Reg_Out : out std_logic_vector(7 downto 0)
    );
  end component;

  -- Sinyal untuk menghubungkan ke UUT
  signal Clock   : std_logic := '0';
  signal Reset   : std_logic := '1';
  signal Reg_In  : std_logic_vector(7 downto 0) := (others => '0');
  signal EN      : std_logic := '0';
  signal Reg_Out : std_logic_vector(7 downto 0);

  -- Clock period
  constant clk_period : time := 10 ns;

begin

  -- Instansiasi Unit Under Test
  uut: reg
    port map (
      Clock   => Clock,
      Reset   => Reset,
      Reg_In  => Reg_In,
      EN      => EN,
      Reg_Out => Reg_Out
    );

  -- Clock Generator
  clk_process : process
  begin
    while true loop
      Clock <= '0';
      wait for clk_period / 2;
      Clock <= '1';
      wait for clk_period / 2;
    end loop;
  end process;

  -- Stimulus Process
  stim_proc : process
  begin
    -- Reset aktif (asinkron)
    Reset <= '0';
    wait for 15 ns;
    Reset <= '1';

    -- Beri data pertama dengan EN aktif
    EN <= '1';
    Reg_In <= x"AA";
    wait for clk_period;

    -- Beri data kedua dengan EN nonaktif (harus tetap AA)
    EN <= '0';
    Reg_In <= x"55";
    wait for clk_period;

    -- EN aktif kembali, data berubah
    EN <= '1';
    Reg_In <= x"F0";
    wait for clk_period;

    -- Selesai
    wait;
  end process;

end architecture;
