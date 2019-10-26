defmodule Diamondway.NotesTest do
  use Diamondway.DataCase

  alias Diamondway.Notes

  alias Diamondway.Notes.Note

  @valid_attrs %{body: "some body"}
  @update_attrs %{body: "some updated body"}
  @invalid_attrs %{body: nil}

  test "get_note!/1 returns the note with given id" do
    note = insert(:note)
    %Note{} = actual = Notes.get_note!(note.id)
    assert actual.id == note.id
    assert actual.guest_id == note.guest_id
    assert actual.user_id == note.user_id
  end

  describe "list_guest_notes/1" do
    test "returns notes as maps" do
      user = insert(:user, display_name: "Francis")
      guest = insert(:guest, first_name: "Jan", last_name: "Paweł II")
      insert(:note, user: user, guest: guest, body: "First note")
      insert(:note, user: user, guest: guest, body: "Second note")
      notes = Notes.list_guest_notes(guest)
    end
  end

  describe "create_guest_note/3" do
    test "creates not with valid params" do
      guest = insert(:guest)
      user = insert(:user)
      assert {:ok, %Note{} = note} = Notes.create_guest_note(guest, user, "Jan Paweł II")
      assert note.body == "Jan Paweł II"
    end

    test "returns error without text params" do
      guest = insert(:guest)
      user = insert(:user)
      assert {:error, %Ecto.Changeset{}} = Notes.create_guest_note(guest, user, "")
    end
  end
end
