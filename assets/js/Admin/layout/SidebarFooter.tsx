import React from "react";

export default function SidebarFooter(_props?: any) {
  return (
    <footer className="admin__sidebar__footer">
      <a href="/admin/logout" className="button ui primary">
        Sign out
      </a>
      <p>
        &copy; 2019 by Karol Moroz.
        <br />
        Licensed with BSD 3-clause license.
      </p>
    </footer>
  );
}
