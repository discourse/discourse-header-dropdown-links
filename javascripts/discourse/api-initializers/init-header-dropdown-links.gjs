import { apiInitializer } from "discourse/lib/api";
import HeaderDropdownLinks from "../components/header-dropdown-links";

export default apiInitializer((api) => {
  api.renderInOutlet("below-site-header", HeaderDropdownLinks);
});
