import React from "react";

export default function SidebarFooter(_props?: any) {
  return (
    <footer className="admin__sidebar__footer">
      <a href="/admin/logout" className="button ui primary">
        Sign out
      </a>
      <p>
        &copy; 2019 Karol Moroz, licensed with BSD-3.
      </p>
    </footer>
  );
}
