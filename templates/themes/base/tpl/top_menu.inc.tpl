    {* Get the frequently used functions in a variable in order to optimize the script and call this function only once in the file *}
      {{
        $is_admin_auth = AdminCore::auth();
        $is_user_auth = UserCore::auth();
        $is_aff_auth = AffiliateCore::auth()
      }}

    {* Creating Objects *}
      {{ $oSession = new Framework\Session\Session() }}

    {* Menu for All *}
      <nav class="navbar navbar-default navbar-fixed-top" role="navigation">
        <div class="container">
        <!-- Brand and toggle get grouped for better mobile display -->
          <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
              <span class="sr-only">Toggle navigation</span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
            </button>
            <div role="banner" id="logo" class="navbar-brand"><h1><a href="{{ $design->homePageUrl() }}" title="{slogan}">{site_name}</a></h1></div>
          </div>

        <!-- Collect the nav links, forms, and other content for toggling -->
          <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav">

    {* Guest Menu *}

      {if !$is_user_auth AND !$is_aff_auth AND !$is_admin_auth}

        <li class="bold"><a href="{{ $design->url('user','signup','step1') }}" title="{lang 'Join Now!'}">{lang 'Join Now!'}</a></li>
        <li><a href="{{ $design->url('user', 'main','login') }}" title="{lang 'Login'}" data-load="ajax">{lang 'Login'}</a></li>

      {/if}


    {* Menu Guest, Member and Admin *}

      {if !$is_aff_auth}

        <li class="dropdown"><a href="{{ $design->url('user', 'browse', 'index') }}" title="{lang 'Members'}" class="dropdown-toggle" role="button" aria-expanded="false" data-toggle="dropdown" data-load="ajax"><i class="fa fa-user fa-fw"></i> {lang 'People'} <span class="caret"></span></a>
          <ul class="dropdown-menu" role="menu">
            <li><a href="{{ $design->url('user', 'browse', 'index') }}" rel="nofollow" title="{lang 'Members'}" data-load="ajax">{lang 'People'}</a></li>

            <li class="menu-item dropdown dropdown-submenu"><a href="{{ $design->url('user','search', 'index') }}" title="{lang 'Search the members'}" class="dropdown-toggle" role="button" aria-expanded="false" data-toggle="dropdown" data-load="ajax">{lang 'Search'}</a>
              <ul class="dropdown-menu" role="menu">
                <li><a href="{{ $design->url('user', 'search', 'quick') }}" title="{lang 'Quick Search'}" data-load="ajax">{lang 'Quick Search'}</a></li>
                <li><a href="{{ $design->url('user', 'search', 'advanced') }}" title="{lang 'Advanced Search'}" data-load="ajax">{lang 'Advanced Search'}</a></li>
              </ul>
            </li>

            <li><a href="{{ $design->url('user','country','index',$country.PH7_SH.$city) }}" title="{lang 'Users in %0% through the Map!',$city}"><i class="fa fa-map-marker"></i> {lang 'Users in your Area'}</a></li>

            <li class="menu-item dropdown dropdown-submenu"><a href="{{ $design->url('user', 'birthday', 'index') }}" title="{lang 'Users Birthday'}" class="dropdown-toggle" role="button" aria-expanded="false" data-toggle="dropdown" data-load="ajax">{lang 'Birthday'}</a>
              <ul class="dropdown-menu" role="menu">
                <li><a href="{{ $design->url('user', 'birthday', 'index', 'all') }}" rel="nofollow" title="{lang 'All Birthday'}" data-load="ajax">{lang 'All Birthday'}</a></li>
                <li><a href="{{ $design->url('user', 'birthday', 'index', 'male') }}" title="{lang 'Men Birthday'}" data-load="ajax">{lang 'Men Birthday'}</a></li>
                <li><a href="{{ $design->url('user', 'birthday', 'index', 'female') }}" title="{lang 'Women Birthday'}" data-load="ajax">{lang 'Women Birthday'}</a></li>
                <li><a href="{{ $design->url('user', 'birthday', 'index', 'couple') }}" title="{lang 'Couples Birthday'}" data-load="ajax">{lang 'Couples Birthday'}</a></li>
              </ul>
            </li>
          </ul>
        </li>
      {/if}


    {* Menu Guest, Member and LoginUserAs of Admin Panel *}

      {if ( !$is_aff_auth AND !$is_admin_auth ) OR $oSession->exists('login_user_as') }

        {if $is_chat_enabled OR $is_chatroulette_enabled}
          <li class="dropdown"><a href="{{ $design->url('chat','home','index') }}" title="{lang 'The Free Chat Rooms'}" class="dropdown-toggle" role="button" aria-expanded="false" data-toggle="dropdown" data-load="ajax">{lang 'Chat'} <span class="caret"></span></a>
            <ul class="dropdown-menu" role="menu">
              {if $is_chat_enabled}
                <li><a href="{{ $design->url('chat','home','index') }}" rel="nofollow" title="{lang 'Video Chat'}" data-load="ajax">{lang 'Chat'}</a></li>
              {/if}

              {if $is_chatroulette_enabled}
                <li><a href="{{ $design->url('chatroulette','home','index') }}" title="{lang 'Chat Roulette'}">{lang 'Chatroulette'}</a></li>
              {/if}

            </ul>
          </li>
        {/if}

        {if $is_picture_enabled}
          <li class="dropdown"><a href="{{ $design->url('picture','main','index') }}" title="{lang 'Photo Gallery'}" class="dropdown-toggle" role="button" aria-expanded="false" data-toggle="dropdown" data-load="ajax">{lang 'Photo'} <span class="caret"></span></a>
            <ul class="dropdown-menu" role="menu">
              <li><a href="{{ $design->url('picture','main','index') }}" rel="nofollow" title="{lang 'Photo Gallery'}" data-load="ajax">{lang 'Photos'}</a></li>

              {if $is_hotornot_enabled}
                <li><a href="{{ $design->url('hotornot','main','rating') }}" title="{lang 'Hot Or Not'}" data-load="ajax">{lang 'Hot Or Not'}</a></li>
              {/if}

              <li><a href="{{ $design->url('picture','main','search') }}" title="{lang 'Search Photos'}" data-load="ajax">{lang 'Search'}</a></li>
            </ul>
          </li>
        {/if}

        {if $is_video_enabled}
          <li class="dropdown"><a href="{{ $design->url('video','main','index') }}" title="{lang 'Video Gallery'}" class="dropdown-toggle" role="button" aria-expanded="false" data-toggle="dropdown" data-load="ajax">{lang 'Video'} <span class="caret"></span></a>
            <ul class="dropdown-menu" role="menu">
              <li><a href="{{ $design->url('video','main','index') }}" rel="nofollow" title="{lang 'Video Gallery'}" data-load="ajax">{lang 'Videos'}</a></li>
              <li><a href="{{ $design->url('video','main','search') }}" title="{lang 'Search Videos'}" data-load="ajax">{lang 'Search'}</a></li>
            </ul>
          </li>
        {/if}

        {if $is_game_enabled}
          <li class="dropdown"><a href="{{ $design->url('game','main','index') }}" title="{lang 'Games Zone'}" class="dropdown-toggle" role="button" aria-expanded="false" data-toggle="dropdown" data-load="ajax">{lang 'Game'} <span class="caret"></span></a>
            <ul class="dropdown-menu" role="menu">
              <li><a href="{{ $design->url('game','main','index') }}" rel="nofollow" title="{lang 'Games Zone'}" data-load="ajax">{lang 'Game'}</a></li>
              <li><a href="{{ $design->url('game','main','search') }}" title="{lang 'Search Games'}" data-load="ajax">{lang 'Search'}</a></li>
            </ul>
          </li>
        {/if}

        {if $is_forum_enabled}
          <li class="dropdown"><a href="{{ $design->url('forum','forum','index') }}" title="{lang 'Forums'}" class="dropdown-toggle" role="button" aria-expanded="false" data-toggle="dropdown" data-load="ajax">{lang 'Forum'} <span class="caret"></span></a>
            <ul class="dropdown-menu" role="menu">
              <li><a href="{{ $design->url('forum','forum','index') }}" rel="nofollow" title="{lang 'Forums'}" data-load="ajax">{lang 'Forum'}</a></li>
              <li><a href="{{ $design->url('forum','forum','search') }}" title="{lang 'Search Topics'}" data-load="ajax">{lang 'Search'}</a></li>
            </ul>
          </li>
        {/if}

        {if $is_note_enabled}
          <li class="dropdown"><a href="{{ $design->url('note','main','index') }}" title="{lang 'Community Notes'}" class="dropdown-toggle" role="button" aria-expanded="false" data-toggle="dropdown" data-load="ajax">{lang 'Note'} <span class="caret"></span></a>
            <ul class="dropdown-menu" role="menu">
              <li><a href="{{ $design->url('note','main','index') }}" rel="nofollow" title="{lang 'Community Notes'}" data-load="ajax">{lang 'Notes'}</a></li>
              <li><a href="{{ $design->url('note','main','search') }}" title="{lang 'Search Notes'}" data-load="ajax">{lang 'Search'}</a></li>
            </ul>
          </li>
        {/if}

      {/if}


    {* Member Menu *}

        {if $is_user_auth AND ( !$is_aff_auth AND !$is_admin_auth ) OR $oSession->exists('login_user_as') }

          <li class="dropdown"><a href="{{ $design->url('mail','main','inbox') }}" title="{lang 'My Emails'}" class="dropdown-toggle" role="button" aria-expanded="false" data-toggle="dropdown"><i class="fa fa-envelope-o fa-fw"></i> {lang 'Mail'} <span class="badge">{count_unread_mail}</span> <span class="caret"></span></a>
            <ul class="dropdown-menu" role="menu">
              <li><a href="{{ $design->url('mail','main','compose') }}" title="{lang 'Compose'}">{lang 'Compose'}</a></li>
              <li><a href="{{ $design->url('mail','main','inbox') }}" title="{lang 'Inbox'}">{lang 'Inbox'}</a></li>
              <li><a href="{{ $design->url('mail','main','outbox') }}" title="{lang 'Outbox'}">{lang 'Outbox'}</a></li>
              <li><a href="{{ $design->url('mail','main','trash') }}" title="{lang 'Trash'}">{lang 'Trash'}</a></li>
              <li><a href="{{ $design->url('mail','main','search') }}" title="{lang 'Find Messages'}">{lang 'Search'}</a></li>
            </ul>
          </li>

          <noscript>
            <li class="dropdown"><a href="{{ $design->url('user','setting','edit') }}" title="{lang 'Settings'}" class="dropdown-toggle" role="button" aria-expanded="false" data-toggle="dropdown">{lang 'Settings'} <span class="caret"></span></a>
              <ul class="dropdown-menu" role="menu">
                <li><a href="{{ $design->url('user','setting','edit') }}">{lang 'Edit Profile'}</a></li>
                <li><a href="{{ $design->url('user','setting','design') }}">{lang 'Design Profile'}</a></li>
                <li><a href="{{ $design->url('user','setting','notification') }}">{lang 'Notifications'}</a></li>
                <li><a href="{{ $design->url('user','setting','privacy') }}">{lang 'Privacy Setting'}</a></li>
                <li><a href="{{ $design->url('user','setting','password') }}"><i class="fa fa-key fa-fw"></i> {lang 'Change Password'}</a></li>
              </ul>
            </li>
          </noscript>

          <li class="dropdown"><a href="{{ $design->url('user','account','index') }}" title="{lang 'My Account'}" class="dropdown-toggle" role="button" aria-expanded="false" data-toggle="dropdown">{lang 'Account'} <span class="caret"></span></a>
            <ul class="dropdown-menu" role="menu">
              <li><a href="{{ $design->url('user','setting','index') }}" title="{lang 'My Settings'}"><i class="fa fa-cog fa-fw"></i> {lang 'My Settings'}</a></li>
              <li><a href="{% (new UserCore)->getProfileLink($oSession->get('member_username')) %}" title="{lang 'See My Profile'}"><i class="fa fa-user fa-fw"></i> {lang 'See My Profile'}</a></li>
              <li><a href="{{ $design->url('user','setting','avatar') }}" title="{lang 'Change My Profile Photo'}">{lang 'Change My Profile Photo'}</a></li>

              {if $is_picture_enabled}
                <li class="menu-item dropdown dropdown-submenu"><a href="{{ $design->url('picture','main','index') }}" title="{lang 'Photo Gallery'}" class="dropdown-toggle" role="button" aria-expanded="false" data-toggle="dropdown" data-load="ajax">{lang 'Photo Gallery'}</a>
                  <ul class="dropdown-menu" role="menu">
                    <li><a href="{{ $design->url('picture','main','addalbum') }}" title="{lang 'Add an Album'}">{lang 'Add an Album'}</a></li>
                    <li><a href="{{ $design->url('picture','main','albums', $oSession->get('member_username')) }}" title="{lang 'My Albums'}" data-load="ajax">{lang 'My Albums'}</a></li>
                  </ul>
                </li>
              {/if}

              {if $is_video_enabled}
                <li class="menu-item dropdown dropdown-submenu"><a href="{{ $design->url('video','main','index') }}" title="{lang 'Videos Gallery'}" class="dropdown-toggle" role="button" aria-expanded="false" data-toggle="dropdown" data-load="ajax">{lang 'Videos Gallery'}</a>
                  <ul class="dropdown-menu" role="menu">
                    <li><a href="{{ $design->url('video','main','addalbum') }}" title="{lang 'Add an Album'}">{lang 'Add an Album'}</a></li>
                    <li><a href="{{ $design->url('video','main','albums', $oSession->get('member_username')) }}" title="{lang 'My Albums'}" data-load="ajax">{lang 'My Albums'}</a></li>
                  </ul>
                </li>
              {/if}

              {if $is_note_enabled}
                <li class="menu-item dropdown dropdown-submenu"><a href="{{ $design->url('note','main','index') }}" title="{lang 'Notes'}" class="dropdown-toggle" role="button" aria-expanded="false" data-toggle="dropdown">{lang 'Note'}</a>
                  <ul class="dropdown-menu" role="menu">
                    <li><a href="{{ $design->url('note','main','add') }}" title="{lang 'Add a Note'}">{lang 'Add a Note'}</a></li>
                    <li><a href="{{ $design->url('note','main','author', $oSession->get('member_username')) }}" title="{lang 'My Notes'}">{lang 'My Notes'}</a></li>
                  </ul>
                </li>
              {/if}

              <li class="menu-item dropdown dropdown-submenu"><a href="{{ $design->url('user','friend','index') }}" title="{lang 'Friends Management'}" class="dropdown-toggle" role="button" aria-expanded="false" data-toggle="dropdown">{lang 'Friends Management'} <span class="badge">{count_pen_friend_request}</span></a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="{{ $design->url('user','friend','index') }}" title="{lang 'Friends List'}">{lang 'Friends List'}</a></li>
                  <li><a href="{{ $design->url('user','friend','search',$oSession->get('member_username')) }}" title="{lang 'Find a friend in my list'}">{lang 'Find a Friend'}</a></li>
                </ul>
              </li>

              <li class="menu-item dropdown dropdown-submenu"><a href="{{ $design->url('user','visitor','index') }}" title="{lang 'Who Visited My Profile'}" class="dropdown-toggle" role="button" aria-expanded="false" data-toggle="dropdown">{lang 'Who See Me'}</a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="{{ $design->url('user','visitor','index') }}" title="{lang 'Who Visited My Profile'}">{lang 'Who See Me'}</a></li>
                  <li><a href="{{ $design->url('user','visitor','search') }}" title="{lang 'Find who visited my profile'}">{lang 'Find Visitor(s)'}</a></li>
                </ul>
              </li>

              <li><a href="{{ $design->url('user','main','logout') }}" title="{lang 'Logout'}"><i class="fa fa-sign-out"></i> {lang 'Logout'}</a></li>
            </ul>
          </li>

      {/if}


    {* Affiliate Menu *}

      {if $is_aff_auth AND ( !$is_user_auth AND !$is_admin_auth OR $oSession->exists('login_affiliate_as') ) }

        <li><a href="{{ $design->url('affiliate','ads','index') }}" title="{lang 'Gets Banners'}">{lang 'Banners'}</a></li>

        <li class="dropdown"><a href="{{ $design->url('affiliate','account','index') }}" title="{lang 'My Account'}" class="dropdown-toggle" role="button" aria-expanded="false" data-toggle="dropdown">{lang 'Account'} <span class="caret"></span></a>
          <ul class="dropdown-menu" role="menu">
            <li><a href="{{ $design->url('affiliate','account','index') }}" title="{lang 'My Account'}">{lang 'Account'}</a></li>
            <li><a href="{{ $design->url('affiliate','account','edit') }}" title="{lang 'Edit my Account'}">{lang 'Edit my account'}</a></li>
            <li><a href="{{ $design->url('affiliate','account','password') }}" title="{lang 'Change Password'}"><i class="fa fa-key fa-fw"></i> {lang 'Change Password'}</a></li>
            <li><a href="{{ $design->url('affiliate','home','logout') }}" title="{lang 'Logout'}"><i class="fa fa-sign-out"></i> {lang 'Logout'}</a></li>
          </ul>
        </li>

      {/if}


    {* Admin Menu *}

      {if $is_admin_auth AND ( !$is_user_auth AND !$is_aff_auth ) }

        <li class="dropdown"><a href="{{ $design->url(PH7_ADMIN_MOD,'user','index') }}" title="{lang 'Users/Admins Manager'}" class="dropdown-toggle" role="button" aria-expanded="false" data-toggle="dropdown"><i class="fa fa-user fa-fw"></i> {lang 'Users/Admins'} <span class="caret"></span></a>
          <ul class="dropdown-menu" role="menu">
            <li class="menu-item dropdown dropdown-submenu"><a href="{{ $design->url(PH7_ADMIN_MOD,'user','browse') }}" title="{lang 'Browse Users'}" class="dropdown-toggle" role="button" aria-expanded="false" data-toggle="dropdown">{lang 'Users'}</a>
              <ul class="dropdown-menu" role="menu">
                <li><a href="{{ $design->url(PH7_ADMIN_MOD,'user','browse') }}" title="{lang 'Browse Users'}">{lang 'Browse'}</a></li>
                <li><a href="{{ $design->url(PH7_ADMIN_MOD,'user','search') }}" title="{lang 'Search Users'}">{lang 'Search'}</a></li>
                <li><a href="{{ $design->url('report','admin','index') }}" title="{lang 'Report'}">{lang 'Report'}</a></li>
                <li><a href="{{ $design->url(PH7_ADMIN_MOD,'user','add') }}" title="{lang 'Add a User'}">{lang 'Add User'}</a></li>
                <li><a href="{{ $design->url(PH7_ADMIN_MOD,'user','import') }}" title="{lang 'Import Users'}">{lang 'Import Users'}</a></li>
                <li><a href="{{ $design->url(PH7_ADMIN_MOD,'user','addfakeprofiles') }}" title="{lang 'Fake Profiles Automatic Generator'}">{lang 'Fake Profile Generator'}</a></li>
                <li class="menu-item dropdown dropdown-submenu"><a href="{{ $design->url('field','field','all','user') }}" title="{lang 'User Fields'}" class="dropdown-toggle" role="button" aria-expanded="false" data-toggle="dropdown">{lang 'User Fields'}</a>
                  <ul class="dropdown-menu" role="menu">
                    <li><a href="{{ $design->url('field','field','all','user') }}" title="{lang 'Fields List'}">{lang 'Fields List'}</a></li>
                    <li><a href="{{ $design->url('field','field','add','user') }}" title="{lang 'Add Fields'}">{lang 'Add Fields'}</a></li>
                  </ul>
                </li>
              </ul>
            </li>
            <li class="menu-item dropdown dropdown-submenu"><a href="{{ $design->url(PH7_ADMIN_MOD,'admin','browse') }}" title="{lang 'Browse Admins'}" class="dropdown-toggle" role="button" aria-expanded="false" data-toggle="dropdown">{lang 'Admins'}</a>
              <ul class="dropdown-menu" role="menu">
                <li><a href="{{ $design->url(PH7_ADMIN_MOD,'admin','browse') }}" title="{lang 'Browse Admins'}">{lang 'Browse'}</a></li>
                <li><a href="{{ $design->url(PH7_ADMIN_MOD,'admin','search') }}" title="{lang 'Search an Admin'}">{lang 'Search'}</a></li>
                <li><a href="{{ $design->url(PH7_ADMIN_MOD,'admin','add') }}" title="{lang 'Add an Admin'}">{lang 'Add Admin'}</a></li>
              </ul>
            </li>
          </ul>
        </li>

        <li class="dropdown"><a href="{{ $design->url(PH7_ADMIN_MOD,'setting','index') }}" title="{lang 'Settings'}" class="dropdown-toggle" role="button" aria-expanded="false" data-toggle="dropdown"><i class="fa fa-cog fa-fw"></i> {lang 'Settings'} <span class="caret"></span></a>
          <ul class="dropdown-menu" role="menu">
            <li><a href="{{ $design->url(PH7_ADMIN_MOD,'setting','index') }}" title="{lang 'General Settings'}">{lang 'General'}</a></li>
            <li><a href="{{ $design->url(PH7_ADMIN_MOD, 'setting','metamain') }}" title="{lang 'Settings'}">{lang 'Meta Tags'}</a></li>
            <li><a href="{{ $design->url(PH7_ADMIN_MOD,'setting','ads') }}" title="{lang 'Add Banners on the best click-through-rate locations'}">{lang 'Advertisement'}</a></li>
            <li><a href="{{ $design->url(PH7_ADMIN_MOD,'setting','analyticsapi') }}" title="{lang 'Analytics Code'}">{lang 'Analytics Code'}</a></li>
            <li><a href="{{ $design->url(PH7_ADMIN_MOD,'setting', 'style') }}" title="{lang 'Custom Style'}">{lang 'Style'}</a></li>
            <li><a href="{{ $design->url(PH7_ADMIN_MOD,'setting', 'script') }}" title="{lang 'JavaScript Injection'}">{lang 'Script'}</a></li>
            <li><a href="{{ $design->url(PH7_ADMIN_MOD,'setting', 'license') }}" title="{lang 'License Key'}">{lang 'License'}</a></li>
          </ul>
        </li>

        <li class="dropdown"><a href="{{ $design->url(PH7_ADMIN_MOD,'module','index') }}" title="{lang 'Modules Manager'}" class="dropdown-toggle" role="button" aria-expanded="false" data-toggle="dropdown">{lang 'Mods'} <span class="caret"></span></a>
          <ul class="dropdown-menu" role="menu">
            <li><a href="{{ $design->url(PH7_ADMIN_MOD,'module','disable') }}" title="{lang 'Enable/Disable System Modules'}">{lang 'Enable/Disable Modules'}</a></li>
            <li><a href="{{ $design->url(PH7_ADMIN_MOD,'module','index') }}" title="{lang 'Third-party Modules Manager'}">{lang 'Third-party Mods Manager'}</a></li>

            {if $is_newsletter_enabled}
              <li class="menu-item dropdown dropdown-submenu"><a href="{{ $design->url('newsletter', 'admin', 'index') }}" title="{lang 'Mass Mailer'}" class="dropdown-toggle" role="button" aria-expanded="false" data-toggle="dropdown">{lang 'Newsletters'}</a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="{{ $design->url('newsletter', 'admin', 'index') }}" title="{lang 'Mass Mailer'}">{lang 'Newsletters'}</a></li>
                  <li class="menu-item dropdown dropdown-submenu"><a href="{{ $design->url('newsletter', 'admin', 'browse') }}" title="{lang 'Browse Subscribers'}" class="dropdown-toggle" role="button" aria-expanded="false" data-toggle="dropdown">{lang 'Subscribers'}</a>
                    <ul class="dropdown-menu" role="menu">
                      <li><a href="{{ $design->url('newsletter', 'admin', 'browse') }}" title="{lang 'Browse Subscribers'}">{lang 'Browse'}</a></li>
                      <li><a href="{{ $design->url('newsletter', 'admin', 'search') }}" title="{lang 'Search Subscribers'}">{lang 'Search'}</a></li>
                    </ul>
                  </li>
                </ul>
              </li>
            {/if}

            {if $is_forum_enabled}
              <li><a href="{{ $design->url('forum','admin','index') }}" title="{lang 'Forum Admin'}">{lang 'Forum'}</a></li>
            {/if}

            {if $is_blog_enabled}
              <li class="menu-item dropdown dropdown-submenu"><a href="{{ $design->url('blog','admin','index') }}" title="{lang 'Admin Blog'}">{lang 'Blog'}</a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="{{ $design->url('blog','admin','index') }}" title="{lang 'Blog Admin'}">{lang 'Blog Admin'}</a></li>
                  <li><a href="{{ $design->url('blog','admin','add') }}" title="{lang 'Add a Blog Post'}">{lang 'Add a Post'}</a></li>
                </ul>
              </li>
            {/if}

            {if $is_game_enabled}
              <li class="menu-item dropdown dropdown-submenu"><a href="{{ $design->url('game','admin','index') }}" title="{lang 'Admin Game'}" class="dropdown-toggle" role="button" aria-expanded="false" data-toggle="dropdown">{lang 'Game'}</a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="{{ $design->url('game','admin','index') }}" title="{lang 'Admin Game'}">{lang 'Admin Game'}</a></li>
                  <li><a href="{{ $design->url('game','admin','add') }}" title="{lang 'Add a Game'}">{lang 'Add a Game'}</a></li>
                </ul>
              </li>
            {/if}

            {if $is_affiliate_enabled}
              <li class="menu-item dropdown dropdown-submenu"><a href="{{ $design->url('affiliate','admin','index') }}" title="{lang 'Affiliate Admin Manager'}" class="dropdown-toggle" role="button" aria-expanded="false" data-toggle="dropdown">{lang 'Affiliate'}</a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="{{ $design->url('affiliate','admin','banner') }}" title="{lang 'Banners Manager'}">{lang 'Banners'}</a></li>
                  <li><a href="{{ $design->url('affiliate','admin','browse') }}" title="{lang 'Affiliates List'}">{lang 'Browse Affiliates'}</a></li>
                  <li><a href="{{ $design->url('affiliate','admin','search') }}" title="{lang 'Search an Affiliate'}">{lang 'Search an Affiliate'}</a></li>
                  <li><a href="{{ $design->url('affiliate','admin','add') }}" title="{lang 'Add an Affiliate'}">{lang 'Add Affiliate'}</a></li>
                  <li><a href="{{ $design->url('affiliate','admin','config') }}" title="{lang 'Affiliate Settings'}">{lang 'Settings'}</a></li>
                  <li class="menu-item dropdown dropdown-submenu"><a href="{{ $design->url('field','field','all','aff') }}" title="{lang 'Affiliate Fields'}" class="dropdown-toggle" role="button" aria-expanded="false" data-toggle="dropdown">{lang 'Affiliate Fields'}</a>
                    <ul class="dropdown-menu" role="menu">
                      <li><a href="{{ $design->url('field','field','all','aff') }}" title="{lang 'Fields List'}">{lang 'Fields List'}</a></li>
                      <li><a href="{{ $design->url('field','field','add','aff') }}" title="{lang 'Add Fields'}">{lang 'Add Fields'}</a></li>
                    </ul>
                  </li>
                </ul>
              </li>
            {/if}

            <li class="menu-item dropdown dropdown-submenu"><a href="{{ $design->url('payment','admin','index') }}" title="{lang 'Payment System'}" class="dropdown-toggle" role="button" aria-expanded="false" data-toggle="dropdown">{lang 'Payment'}</a>
              <ul class="dropdown-menu" role="menu">
                <li><a href="{{ $design->url(PH7_ADMIN_MOD,'setting','general') }}#p=registration" title="{lang 'Set the Default Membership Group for new Users'}">{lang 'Default Membership Group'}</a></li>
                <li><a href="{{ $design->url('payment','admin','membershiplist') }}" title="{lang 'Memberships List'}">{lang 'Memberships List'}</a></li>
                <li><a href="{{ $design->url('payment','admin','addmembership') }}" title="{lang 'Membership Management'}">{lang 'Add a new Membership'}</a></li>
                <li><a href="{{ $design->url('payment','admin','config') }}" title="{lang 'Payment Gateway Config'}">{lang 'Gateway Config'}</a></li>
              </ul>
            </li>

            <li class="menu-item dropdown dropdown-submenu"><a href="{{ $design->url('mail','admin','index') }}" title="{lang 'Email Management'}" class="dropdown-toggle" role="button" aria-expanded="false" data-toggle="dropdown">{lang 'Email Management'}</a>
              <ul class="dropdown-menu" role="menu">
                <li><a href="{{ $design->url('mail','admin','msglist') }}" title="{lang 'Messages Monitor'}">{lang 'Messages Monitor'}</a></li>
                <li><a href="{{ $design->url('mail','main','search') }}" title="{lang 'Search Email'}">{lang 'Search Message'}</a></li>
              </ul>
            </li>

            {if $is_connect_enabled}
              <li><a href="{{ $design->url('connect', 'admin', 'config') }}">{lang 'Universal Login Config'}</a></li>
            {/if}

          </ul>
        </li>

        {* Moderate Count *}
          {{
            $oModeratorModel = new ModeratorCoreModel();

            $count_moderate_total_album_picture = $oModeratorModel->totalAlbumsPicture();
            $count_moderate_total_picture = $oModeratorModel->totalPictures();
            $count_moderate_total_album_video = $oModeratorModel->totalAlbumsVideo();
            $count_moderate_total_video = $oModeratorModel->totalVideos();
            $count_moderate_total_avatar = $oModeratorModel->totalAvatars();
            $count_moderate_total_background = $oModeratorModel->totalBackgrounds();
            $count_moderate_total_note = $oModeratorModel->totalNotes();

            unset($oModeratorModel);
          }}

        <li class="dropdown"><a href="{{ $design->url(PH7_ADMIN_MOD,'moderator','index') }}" title="{lang 'User Moderation'}" class="dropdown-toggle" role="button" aria-expanded="false" data-toggle="dropdown">{lang 'Moderation'} <span class="caret"></span></a>
          <ul class="dropdown-menu" role="menu">
            <li><a href="{{ $design->url(PH7_ADMIN_MOD,'moderator','albumpicture') }}" title="{lang 'Moderate Albums'}">{lang 'Picture Album'} <span class="badge">{count_moderate_total_album_picture}</span></a></li>
            <li><a href="{{ $design->url(PH7_ADMIN_MOD,'moderator','picture') }}" title="{lang 'Moderate Pictures'}">{lang 'Picture'} <span class="badge">{count_moderate_total_picture}</span></a></li>
            <li><a href="{{ $design->url(PH7_ADMIN_MOD,'moderator','albumvideo') }}" title="{lang 'Moderate Albums'}">{lang 'Video Album'} <span class="badge">{count_moderate_total_album_video}</span></a></li>
            <li><a href="{{ $design->url(PH7_ADMIN_MOD,'moderator','video') }}" title="{lang 'Moderate Videos'}">{lang 'Video'} <span class="badge">{count_moderate_total_video}</span></a></li>
            <li><a href="{{ $design->url(PH7_ADMIN_MOD,'moderator','avatar') }}" title="{lang 'Moderate Avatars'}">{lang 'Avatar'} <span class="badge">{count_moderate_total_avatar}</span></a></li>
            <li><a href="{{ $design->url(PH7_ADMIN_MOD,'moderator','background') }}" title="{lang 'Moderate Profile Background'}">{lang 'Profile Background'} <span class="badge">{count_moderate_total_background}</span></a></li>

            {if $is_note_enabled}
              <li class="menu-item dropdown dropdown-submenu"><a href="{{ $design->url('note','admin','index') }}" title="{lang 'Moderate Note'}" class="dropdown-toggle" role="button" aria-expanded="false" data-toggle="dropdown">{lang 'Notes'} <span class="badge">{count_moderate_total_note}</span></a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="{{ $design->url('note','admin','unmoderated') }}" title="{lang 'Moderate the Note Posts'}">{lang 'Note Posts'} <span class="badge">{count_moderate_total_note}</span></a></li>
                </ul>
              </li>
            {/if}

            {if $is_webcam_enabled}
              <li><a href="{{ $design->url(PH7_ADMIN_MOD,'moderator','picturewebcam') }}" title="{lang 'Moderate the Pictures Webcam'}">{lang 'Pictures Webcam'}</a></li>
            {/if}

          </ul>
        </li>

        <li class="dropdown"><a href="{{ $design->url(PH7_ADMIN_MOD,'file','index') }}" title="{lang 'File Management/CMS'}" class="dropdown-toggle" role="button" aria-expanded="false" data-toggle="dropdown">{lang 'Files'} <span class="caret"></span></a>
          <ul class="dropdown-menu" role="menu">
            <li><a href="{{ $design->url(PH7_ADMIN_MOD,'file','display') }}" title="{lang 'Public File Management'}">{lang 'Public Files'}</a></li>
            <li><a href="{{ $design->url(PH7_ADMIN_MOD,'file','display','protected') }}" title="{lang 'Protected File Management'}">{lang 'Protected Files'}</a></li>
            <li><a href="{{ $design->url(PH7_ADMIN_MOD,'file','pagedisplay') }}" title="{lang 'Display Page of Module'}">{lang 'Page Module'}</a></li>
            <li><a href="{{ $design->url(PH7_ADMIN_MOD,'file','maildisplay') }}" title="{lang 'Display Email Template'}">{lang 'Email Template'}</a></li>
            <li><a href="{{ $design->url(PH7_ADMIN_MOD,'file','themedisplay') }}" title="{lang 'Display the all Templates Files'}">{lang 'Templates Files'}</a></li>
            <li><a href="{{ $design->url(PH7_ADMIN_MOD,'file','suggestiondisplay') }}" title="{lang 'Suggestion List'}">{lang 'Suggestion List'}</a></li>
            <li><a href="{{ $design->url(PH7_ADMIN_MOD,'file','bandisplay') }}" title="{lang 'Ban Options'}">{lang 'Ban Options'}</a></li>
          </ul>
        </li>

        <li class="dropdown"><a href="{{ $design->url(PH7_ADMIN_MOD,'tool','index') }}" title="{lang 'Tools'}" class="dropdown-toggle" role="button" aria-expanded="false" data-toggle="dropdown"><i class="fa fa-wrench"></i> {lang 'Tools'} <span class="caret"></span></a>
          <ul class="dropdown-menu" role="menu">
            <li><a href="{{ $design->url(PH7_ADMIN_MOD,'tool','index') }}" title="{lang 'General Tools'}">{lang 'Tools'}</a></li>
            <li><a href="{{ $design->url(PH7_ADMIN_MOD,'tool','envmode') }}" title="{lang 'Change the Environment Mode'}"><i class="fa fa-eye"></i> {lang 'Environment Mode'}</a></li>
            <li class="menu-item dropdown dropdown-submenu"><a href="{{ $design->url(PH7_ADMIN_MOD,'tool','cache') }}" title="{lang 'Caches Management'}" class="dropdown-toggle" role="button" aria-expanded="false" data-toggle="dropdown">{lang 'Caches Management'}</a>
              <ul class="dropdown-menu" role="menu">
                <li><a href="{{ $design->url(PH7_ADMIN_MOD,'tool','cache') }}" title="{lang 'Caches Controls'}">{lang 'Caches Management'}</a></li>
                <li><a href="{{ $design->url(PH7_ADMIN_MOD,'tool','cacheconfig') }}" title="{lang 'Cache Settings'}">{lang 'Cache Settings'}</a></li>
              </ul>
            </li>
            <li><a href="{{ $design->url(PH7_ADMIN_MOD,'tool','backup') }}" title="{lang 'Backup Management'}">{lang 'Backup Management'}</a></li>
            <li><a href="{{ $design->url(PH7_ADMIN_MOD,'tool','freeSpace') }}" title="{lang 'Free Space Server'}">{lang 'Free Space Server'}</a></li>
            <li class="menu-item dropdown dropdown-submenu"><a href="{{ $design->url(PH7_ADMIN_MOD,'info','index') }}" title="{lang 'Information'}" class="dropdown-toggle" role="button" aria-expanded="false" data-toggle="dropdown"><i class="fa fa-info-circle"></i> {lang 'Info'}</a>
              <ul class="dropdown-menu" role="menu">
                <li><a href="{{ $design->url(PH7_ADMIN_MOD,'main','stat') }}" title="{lang 'Site Statistics'}">{lang 'Site Stats'}</a></li>
                <li><a href="{{ $design->url(PH7_ADMIN_MOD,'info','software') }}" title="{lang 'Software'}">{lang 'Software'}</a></li>
                <li><a href="{{ $design->url(PH7_ADMIN_MOD,'info','language') }}" title="{lang 'PHP Info'}">{lang 'PHP'}</a></li>
              </ul>
            </li>
          </ul>
        </li>

        <li class="bold dropdown"><a href="{software_help_url}" title="{lang "Need some Helps? We're here for you!"}" class="dropdown-toggle" role="button" aria-expanded="false" data-toggle="dropdown"><i class="fa fa-life-ring"></i> {lang 'Help'} <span class="caret"></span></a>
          <ul class="dropdown-menu" role="menu">
            <li><a href="{software_help_url}" title="{lang 'Need Technical Support...?'}"><i class="fa fa-life-ring"></i> {lang 'Professional Support'}</a></li>
            <li><a href="{software_doc_url}" title="{lang 'Software Documentation'}"><i class="fa fa-book"></i> {lang 'Documentation'}</a></li>
            <li><a href="http://ph7cms.com/how-to-report-bugs" title="{lang 'Report a Problem'}"><i class="fa fa-bug"></i> {lang 'Report a Bug'}</a></li>
            {* Coming soon ...
            <li><a href="{software_faq_url}" title="{lang 'Frequently Asked Questions'}">{lang 'Faq'}</a></li>
            <li><a href="{software_forum_url}" title="{lang 'Support Forum'}">{lang 'Forum'}</a></li>
            *}
            <li><a href="{software_license_url}" title="{lang 'Buy a License Key'}"><i class="fa fa-key"></i> {lang 'Need a License?'}</a></li>
          </ul>
        </li>

        <li class="dropdown"><a href="{{ $design->url(PH7_ADMIN_MOD,'account','index') }}" title="{lang 'My account'}" class="dropdown-toggle" role="button" aria-expanded="false" data-toggle="dropdown">{lang 'Account'} <span class="caret"></span></a>
          <ul class="dropdown-menu" role="menu">
            <li><a href="{{ $design->url(PH7_ADMIN_MOD,'account','edit') }}" title="{lang 'Edit my account'}"><i class="fa fa-pencil fa-fw"></i> {lang 'Edit ny account'}</a></li>
            <li><a href="{{ $design->url(PH7_ADMIN_MOD,'account','password') }}" title="{lang 'Change Password'}"><i class="fa fa-key fa-fw"></i> {lang 'Change Password'}</a></li>
            <li><a href="{{ $design->url(PH7_ADMIN_MOD,'main','logout') }}" title="{lang 'Logout'}"><i class="fa fa-sign-out"></i> {lang 'Logout'}</a></li>
          </ul>
        </li>

      {/if}

      </ul>
    </div><!-- /.navbar-collapse -->
  </div><!-- /.container-fluid -->
</nav>

{* For LoginUserAs of Admin Panel *}
  {if $is_admin_auth AND $oSession->exists('login_user_as') }
    <p class="center bold loginas"><a href="{{ $design->url(PH7_ADMIN_MOD, 'user', 'logoutuseras') }}">{lang}Click here to switch back to the Admin Panel{/lang}</a></p>
  {elseif $is_admin_auth AND $oSession->exists('login_affiliate_as') }
    <p class="center bold loginas"><a href="{{ $design->url('affiliate', 'admin', 'logoutuseras') }}">{lang}Click here to switch back to the Admin Panel{/lang}</a></p>
  {/if}

    {* Destroy the varaibles *}
      {{
        unset(
          $oSession,
          $is_admin_auth,
          $is_user_auth,
          $is_aff_auth,
          $count_moderate_total_album_picture,
          $count_moderate_total_picture,
          $count_moderate_total_album_video,
          $count_moderate_total_video,
          $count_moderate_total_avatar,
          $count_moderate_total_background,
          $count_moderate_total_note
        )
      }}
