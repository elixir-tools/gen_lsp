# codegen: do not edit
defmodule GenLSP.Structures.WorkDoneProgressBegin do
  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * kind
  * title: Mandatory title of the progress operation. Used to briefly inform about
    the kind of operation being performed.

    Examples: "Indexing" or "Linking dependencies".
  * cancellable: Controls if a cancel button should show to allow the user to cancel the
    long running operation. Clients that don't support cancellation are allowed
    to ignore the setting.
  * message: Optional, more detailed associated progress message. Contains
    complementary information to the `title`.

    Examples: "3/25 files", "project/src/module2", "node_modules/some_dep".
    If unset, the previous progress message (if any) is still valid.
  * percentage: Optional progress percentage to display (value 100 is considered 100%).
    If not provided infinite progress is assumed and clients are allowed
    to ignore the `percentage` value in subsequent in report notifications.

    The value should be steadily rising. Clients are free to ignore values
    that are not following this rule. The value range is [0, 100].
  """
  @derive Jason.Encoder
  typedstruct do
    field :kind, String.t(), enforce: true
    field :title, String.t(), enforce: true
    field :cancellable, boolean()
    field :message, String.t()
    field :percentage, GenLSP.BaseTypes.uinteger()
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      {"kind", :kind} => "begin",
      {"title", :title} => str(),
      optional({"cancellable", :cancellable}) => bool(),
      optional({"message", :message}) => str(),
      optional({"percentage", :percentage}) => int()
    })
  end
end
