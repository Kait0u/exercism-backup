defmodule ProteinTranslation do
  @stop "STOP"

  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {:ok, list(String.t())} | {:error, String.t()}
  def of_rna(rna) do
    triplets =
      rna
      |> String.graphemes()
      |> Enum.chunk_every(3)
      |> Enum.map(&Enum.join/1)
      |> Enum.to_list()

    decode_attempts =
      triplets
      |> Enum.map(&of_codon/1)
      |> Enum.take_while(fn {_, value} -> value != @stop end)
      |> Enum.to_list()



    if Enum.find(decode_attempts, fn {outcome, _} ->
      outcome == :error
    end) do
      {:error, "invalid RNA"}
    else
      {
        :ok,
        decode_attempts
        |> Enum.map(fn {_, value} -> value end)
        |> Enum.to_list()
      }
    end
  end

  @doc """
  Given a codon, return the corresponding protein

  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """
  @spec of_codon(String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def of_codon(codon) do
    protein =
      case codon do
        "UGU" -> "Cysteine"
        "UGC" -> "Cysteine"
        "UUA" -> "Leucine"
        "UUG" -> "Leucine"
        "AUG" -> "Methionine"
        "UUU" -> "Phenylalanine"
        "UUC" -> "Phenylalanine"
        "UCU" -> "Serine"
        "UCC" -> "Serine"
        "UCA" -> "Serine"
        "UCG" -> "Serine"
        "UGG" -> "Tryptophan"
        "UAU" -> "Tyrosine"
        "UAC" -> "Tyrosine"
        "UAA" -> @stop
        "UAG" -> @stop
        "UGA" -> @stop
        _ -> nil
    end

    if protein == nil do
      {:error, "invalid codon"}
    else
      {:ok, protein}
    end
  end
end
