<?php
/**
 * @author         Pierre-Henry Soria <ph7software@gmail.com>
 * @copyright      (c) 2012-2016, Pierre-Henry Soria. All Rights Reserved.
 * @license        GNU General Public License; See PH7.LICENSE.txt and PH7.COPYRIGHT.txt in the root directory.
 * @package        PH7 / App / System / Module / Video / Form
 */
namespace PH7;

use PH7\Framework\Session\Session, PH7\Framework\Mvc\Request\Http;

class EditVideoForm
{

    public static function display()
    {
        if (isset($_POST['submit_edit_video']))
        {
            if (\PFBC\Form::isValid($_POST['submit_edit_video']))
                new EditVideoFormProcess;

            Framework\Url\Header::redirect();
        }

        $oForm = new \PFBC\Form('form_edit_video');
        $oForm->configure(array('action' => '' ));
        $oForm->addElement(new \PFBC\Element\Hidden('submit_edit_video', 'form_edit_video'));
        $oForm->addElement(new \PFBC\Element\Token('edit_video'));

        $oHttpRequest = new Http;
        $oVideo = (new VideoModel)->video((new Session)->get('member_id'), $oHttpRequest->get('album_id'), $oHttpRequest->get('video_id'), 1, 0, 1);
        unset($oHttpRequest);

        $oForm->addElement(new \PFBC\Element\Textbox(t('Name of your video:'), 'title', array('value'=>$oVideo->title, 'required'=>1, 'validation'=>new \PFBC\Validation\Str(2,40))));
        $oForm->addElement(new \PFBC\Element\Textarea(t('Description of your video:'), 'description', array('value'=>$oVideo->description, 'validation'=>new \PFBC\Validation\Str(2,200))));
        $oForm->addElement(new \PFBC\Element\Button);
        $oForm->render();
    }

}
