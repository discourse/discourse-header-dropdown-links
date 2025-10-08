import icon from "discourse/helpers/d-icon";

const HeaderDropdownLinks = <template>
  <div class="header-links">
    <div class="wrap">
      <ul class="header-links__items">
        {{#each settings.header_links as |headerLink|}}
          <li class="header-links__item">
            <a href={{unless headerLink.dropdown_links.length headerLink.url}}>
              <span>
                {{headerLink.title}}
              </span>
              {{#if headerLink.dropdown_links.length}}
                {{icon "angle-down"}}
              {{/if}}
            </a>
            {{#if headerLink.dropdown_links.length}}
              <ul class="header-links__item-dropdown">
                {{#each headerLink.dropdown_links as |dropdownLink|}}
                  <li>
                    <a href={{dropdownLink.url}}>
                      <span>
                        {{dropdownLink.title}}
                      </span>
                      {{#if dropdownLink.description}}
                        <span>
                          {{dropdownLink.description}}
                        </span>
                      {{/if}}
                    </a>
                  </li>
                {{/each}}
              </ul>
            {{/if}}
          </li>
        {{/each}}
      </ul>
    </div>
  </div>
</template>;

export default HeaderDropdownLinks;
