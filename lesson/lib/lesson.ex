defmodule Lesson do
  @moduledoc """
  Documentation for Lesson.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Lesson.hello()
      :world

  """
  def hello do
    :world
  end

  def myfunc do
    "Hello, world!"
  end

  def sleep_rand(n) do
    sleep_time = :rand.uniform(n)
    :timer.sleep(sleep_time)
    IO.puts "#{sleep_time}ミリ秒sleepしました"
    sleep_time
  end

  def execute_sequentially(n) do
    IO.puts "=== 開始: #{n}回rand_sleepを繰り返す ==="
    result = Enum.map(1..n, fn(_) -> sleep_rand(1000) end)
    IO.puts "=== 終了: #{n}回rand_sleepを繰り返す ==="
    result
  end

  def execute_concurrently(n) do
    IO.puts "=== 開始: #{n}回rand_sleepを繰り返す ==="
    result = 1..n
    |> Enum.map(fn(_) -> Task.async(Lesson, :sleep_rand, [1000]) end)
    |> Enum.map(&Task.await/1)

    IO.puts "=== 終了: #{n}回rand_sleepを繰り返す ==="
    result
  end
end
