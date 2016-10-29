defmodule Lumberjack do
  alias Experimental.GenStage

  def go do
    {:ok, reader} = Lumberjack.Reader.start_link(0)
    {:ok, printer} = Lumberjack.Printer.start_link()

    GenStage.sync_subscribe(printer, to: reader)
  end
end
