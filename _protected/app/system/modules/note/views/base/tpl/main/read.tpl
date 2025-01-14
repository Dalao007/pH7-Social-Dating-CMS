<div class="center">

  {if empty($error)}

    <article>
      <time datetime="{% (!empty($post->updatedDate)) ? $dateTime->get($post->updatedDate)->dateTime() : $dateTime->get($post->createdDate)->dateTime() %}" pubdate="pubdate"></time>

      {{ $content = Framework\Parse\Emoticon::init(Framework\Security\Ban\Ban::filterWord($post->content)) }}

      <div class="left"><h4>{lang 'Author: <a href="%0%" data-load="ajax">%1%</a>.', (new UserCore)->getProfileSignupLink($post->username, $post->firstName, $post->sex), $post->firstName}</h4>{{ NoteDesign::thumb($post) }}</div>

      {content}

      <br /><hr />
      {{ NoteDesign::categories($categories, 'note') }}

      {{ $design->like($post->username,$post->firstName,$post->sex) }} | {{ $design->report($post->profileId,$post->username,$post->firstName,$post->sex) }}

      <p class="small italic">{lang 'Posted on:'} {% $dateTime->get($post->createdDate)->dateTime() %} {if !empty($post->updatedDate)} | {lang 'Updated Post:'}{% $dateTime->get($post->updatedDate)->dateTime() %}{/if} | {lang 'Views:'} {% Framework\Mvc\Model\Statistic::getView($post->noteId,'Notes') %}</p>

      {if UserCore::auth() && $member_id === $post->profileId}
        <p><a class="m_button" href="{{ $design->url('note','main','edit',$post->noteId) }}">{lang 'Edit Article'}</a> | {{ $design->popupLinkConfirm(t('Delete Article'), 'note', 'main', 'delete', $post->noteId, 'm_button') }}</p>
      {/if}

      {{ ShareUrlCoreForm::display(Framework\Mvc\Router\Uri::get('note','main','read',"$post->username,$post->postId")) }}
      {{ RatingDesignCore::voting($post->noteId,'Notes','center') }}

      {{ $design->likeApi() }}

      {if $post->enableComment}
        <p>------------------------------------</p>
        {{ CommentDesignCore::link($post->noteId,'Note') }}
      {/if}

      {if AdminCore::auth() && !(new Framework\Session\Session)->exists('login_user_as')}
        {{ $action = ($post->approved == 1) ? 'disapproved' : 'approved' }}
        {{ $text = ($post->approved == 1) ? t('Disapprove') : t('Approve') }}
        <fieldset class="s_tMarg">
          <legend>{lang 'Moderation Action'}</legend>
          <div>{{ LinkCoreForm::display($text, 'note', 'admin', $action, array('note_id'=>$post->noteId, 'post_id'=>$post->postId, 'profile_id'=>$post->profileId)) }} &nbsp; | &nbsp; <a href="{{ $design->url(PH7_ADMIN_MOD,'user','loginuseras',$post->profileId) }}" title="{lang 'Login as this author to edit this post'}">{lang 'Login as this User'}</a></div>
        </fieldset>
      {/if}

    </article>

  {else}

    <p>{error}</p>

  {/if}

</div>
