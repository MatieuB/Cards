defmodule Cards do
  @moduledoc """
    Provides methods for creating and handling a deck of cards
  """

  @doc """
    Returns a list of strings representing a deck of playing cards
  """
  def create_deck do
    values =["Ace","Two","Three","Four","Five","Six","Seven","Eight","Nine","Ten","Jack","Queen","King"]
    suits = ["Spades","Clubs","Hearts","Diamonds"]

    # run multiple comprenshions at once. nested loops return multidimesnional lists
    deck = for value <- values,suit <- suits do
        "#{value} of #{suit}"
    end
  end



  @doc """
    Divides a deck into a hand and the remainder of the deck and the `hand_size` argument indicates how many cards should be in the hand

  ## Examples

      iex> deck = Cards.create_deck
      iex> {hand, deck} = Cards.deal(deck,1)
      iex> hand
      ["Ace of Spades"]

  """
  def deal(deck,hand_size) do
    Enum.split(deck,hand_size)
  end

  @doc """
    Randomizes the order of the deck
  """
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
    Determines whether a deck contains a given card

  ## Examples

      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck,"Ace of Spades")
      true

  """
  def contains?(deck,card) do
    Enum.member?(deck,card)
  end

  @doc """
   Saves a deck to a specified file
  """
  def save(deck,fileName) do
    # erlang encodes to an obj that can be written into a file
    binary = :erlang.term_to_binary(deck)
    File.write(fileName, binary)
  end

  @doc """
    Loads a given deck for play by file name.
  """
  def load(fileName) do
    case File.read(fileName) do
      # comparison and assignment happening here
      {:ok,binary} -> :erlang.binary_to_term(binary)
      {:error,_reason} -> "That file does not exist"
    end
  end

  @doc """
    Conmbines the `create_deck, shuffle`, and `deal` functions.
  """
  def create_hand(hand_size) do
    # no need for a temp deck var with pipe operator

    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end

end
