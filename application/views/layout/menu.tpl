        <div class="startbar-menu" >
            <div class="startbar-collapse" id="startbarCollapse" data-simplebar>
                <div class="d-flex align-items-start flex-column w-100">

                    <ul class="navbar-nav mb-auto w-100">

                     {assign var=sub_menu_count value=0}
                     {foreach from=$SIDE_MENU item=v key=k}
                     {$sub_menu_count=count($v.submenu)}

                     <li class="nav-item {if $v.is_selected}active{/if}" >

                        <a class="nav-link"  {if $sub_menu_count} data-bs-toggle="collapse" role="button"
                        aria-expanded="false" aria-controls="sidebarSale" href="#{$v.id}" {else} href="{$v.link}" {/if}>
                        <i class="{$v.icon} menu-icon"> </i>
                        <span>{$v.text}
                            {if $sub_menu_count} <b class="caret"></b> {/if}
                        </span>
                    </a>

                    {if $sub_menu_count}

                    <div class="collapse {if $v.is_selected}show{/if}" id="{$v.id}">
                        <ul class="nav flex-column">
                            {foreach from=$v.submenu item=i}
                            <li class="nav-item {if $i.is_selected}active{/if}" >
                                <a class="nav-link" href="{$i.link}">{$i.text}</a>
                            </li>
                            {/foreach}

                        </ul>
                    </div>
                    {/if}
                </li>
                {/foreach} 
            </ul>
        </div>
    </div>
</div> 