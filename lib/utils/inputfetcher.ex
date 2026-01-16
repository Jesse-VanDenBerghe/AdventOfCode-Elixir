defmodule InputFetcher do
  def input(year, day) do
    case fetch_in_cache(year, day) do
      {:ok, content} ->
        content

      :error ->
        case fetch_from_web(year, day) do
          {:ok, content} ->
            store_in_cache(year, day, content)
            content

          {:error, reason} ->
            IO.puts("Error fetching input from web: #{reason}")
            nil
        end
    end
  end

  def test_input(year, day) do
    case get_test_input_file_path(year, day)
         |> File.read() do
      {:ok, content} ->
        content

      {:error, reason} ->
        IO.puts("Error reading test input file: #{reason}")
        nil
    end
  end

  defp fetch_in_cache(year, day) do
    get_cache_file_path(year, day)
    |> File.read()
  end

  defp get_test_input_file_path(year, day) do
    "inputs/#{year}/day#{day}.test.txt"
  end

  defp get_cache_file_path(year, day) do
    "inputs/#{year}/day#{day}.txt"
  end

  defp fetch_from_web(year, day) do
    url = "https://adventofcode.com/#{year}/day/#{day}/input"
    headers = [{"Cookie", "session=#{get_session_cookie()}"}]

    case HTTPoison.get(url, headers) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, body}

      {:ok, %HTTPoison.Response{status_code: status_code}} ->
        {:error, "Received status code #{status_code} from server."}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, "HTTP request failed: #{reason}"}
    end
  end

  defp store_in_cache(year, day, content) do
    file_path = get_cache_file_path(year, day)
    dir_path = Path.dirname(file_path)

    case File.mkdir_p(dir_path) do
      :ok ->
        case File.write(file_path, content) do
          :ok -> :ok
          {:error, reason} -> IO.puts("Error writing file #{file_path}: #{reason}")
        end

      {:error, reason} ->
        IO.puts("Error creating directory #{dir_path}: #{reason}")
    end
  end

  defp get_session_cookie() do
    System.get_env("AOC_SESSION_COOKIE") || ""
  end
end
