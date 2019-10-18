defmodule Diamondway.AuditsTest do
  use Diamondway.DataCase

  alias Diamondway.Audits

  describe "audits" do
    alias Diamondway.Audits.Audit

    test "get_audit!/1 returns the audit with given id" do
      audit = insert(:audit) |> reload()
      assert Audits.get_audit!(audit.id) == audit
    end

    test "create_audit/1 with valid data creates a audit" do
      valid_attrs = params_with_assocs(:audit, description: "Confirmed Asian")
      assert {:ok, %Audit{} = audit} = Audits.create_audit(valid_attrs)
      assert audit.description == "Confirmed Asian"
      assert %DateTime{} = audit.timestamp
    end

    test "create_audit/1 with invalid data returns error changeset" do
      invalid_attrs = params_with_assocs(:audit, description: "", guest_id: nil)
      assert {:error, %Ecto.Changeset{}} = Audits.create_audit(invalid_attrs)
    end

    test "delete_audit/1 deletes the audit" do
      audit = insert(:audit)
      assert {:ok, %Audit{}} = Audits.delete_audit(audit)
      assert_raise Ecto.NoResultsError, fn -> Audits.get_audit!(audit.id) end
    end
  end
end
