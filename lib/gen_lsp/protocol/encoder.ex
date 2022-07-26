defprotocol GenLSP.Protocol.Encoder do
  @fallback_to_any true

  def encode(struct)
  def decode(struct, packet)
end

defimpl GenLSP.Protocol.Encoder, for: Any do
  def encode(thing) do
    thing
  end

  def decode(_, packet) do
    packet
  end
end
