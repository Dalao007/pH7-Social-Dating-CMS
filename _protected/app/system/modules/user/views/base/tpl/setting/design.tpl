<div class="col-md-8">

    <p><a href="{path_img_background}" data-popup="image"><img src="{path_img_background}" alt="{lang 'Wallpaper'}" title="{lang 'Your current wallpaper'}" width="160" height="150" /></a></p>

    {if AdminCore::auth() && !UserCore::auth()}
        {{ LinkCoreForm::display(t('Remove wallpaper?'), null, null, null, array('del'=>1)) }}
    {else}
        {{ LinkCoreForm::display(t('Remove wallpaper?'), 'user', 'setting', 'design', array('del'=>1)) }}
    {/if}

    {{ DesignForm::display() }}
</div>