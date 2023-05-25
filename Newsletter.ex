defmodule Newsletter do
  def read_emails(path) do
    # Please implement the read_emails/1 function
    File.read!(path)|>String.split("\n")|>Enum.filter(fn email -> email != "" end)
  end

  def open_log(path) do
    # Please implement the open_log/1 function
    File.open!(path, [:write])
  end

  def log_sent_email(pid, email) do
    # Please implement the log_sent_email/2 function
    IO.binwrite(pid, "#{email}\n")
  end

  def close_log(pid) do
    # Please implement the close_log/1 function
    File.close(pid)
  end

  def send_newsletter(emails_path, log_path, send_fun) do
    # Please implement the send_newsletter/3 function
    log_pid = open_log(log_path)
    read_emails(emails_path)
    |>Enum.map(fn email ->
      if send_fun.(email) == :ok, do: log_sent_email(log_pid, email)
     end)
    close_log(log_pid)
  end
end
