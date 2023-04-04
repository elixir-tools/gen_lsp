# codegen: do not edit
defmodule GenLSP.Structures.FoldingRangeClientCapabilities do
  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * dynamic_registration: Whether implementation supports dynamic registration for folding range
    providers. If this is set to `true` the client supports the new
    `FoldingRangeRegistrationOptions` return value for the corresponding
    server capability as well.
  * range_limit: The maximum number of folding ranges that the client prefers to receive
    per document. The value serves as a hint, servers are free to follow the
    limit.
  * line_folding_only: If set, the client signals that it only supports folding complete lines.
    If set, client will ignore specified `startCharacter` and `endCharacter`
    properties in a FoldingRange.
  * folding_range_kind: Specific options for the folding range kind.

    @since 3.17.0
  * folding_range: Specific options for the folding range.

    @since 3.17.0
  """
  @derive Jason.Encoder
  typedstruct do
    field :dynamic_registration, boolean()
    field :range_limit, GenLSP.BaseTypes.uinteger()
    field :line_folding_only, boolean()
    field :folding_range_kind, map()
    field :folding_range, map()
  end

  @doc false
  @spec schematic() :: Schematic.t()
  def schematic() do
    schema(__MODULE__, %{
      {"dynamicRegistration", :dynamic_registration} => nullable(bool()),
      {"rangeLimit", :range_limit} => nullable(int()),
      {"lineFoldingOnly", :line_folding_only} => nullable(bool()),
      {"foldingRangeKind", :folding_range_kind} =>
        nullable(
          map(%{
            {"valueSet", :value_set} =>
              nullable(list(GenLSP.Enumerations.FoldingRangeKind.schematic()))
          })
        ),
      {"foldingRange", :folding_range} =>
        nullable(
          map(%{
            {"collapsedText", :collapsed_text} => nullable(bool())
          })
        )
    })
  end
end
