<?php
/**
 * @title            Video API Class
 *
 * @author           Pierre-Henry Soria <ph7software@gmail.com>
 * @copyright        (c) 2012-2016, Pierre-Henry Soria. All Rights Reserved.
 * @license          GNU General Public License; See PH7.LICENSE.txt and PH7.COPYRIGHT.txt in the root directory.
 * @package          PH7 / Framework / Video
 * @version          1.0
 * @link             http://hizup.com
 */

namespace PH7\Framework\Video;
defined('PH7') or exit('Restricted access');

use PH7\Framework\Http\Http;

class Api
{

    protected $iWidth, $iHeight;

    public function __construct()
    {
        $this->iWidth = 480;
        $this->iHeight = 295;
    }

    /**
     * @param string $sUrl
     * @return object Class
     */
    public function getVideo($sUrl)
    {
        $sClass = $this->clear($sUrl);
        switch ($sClass)
        {
            case 'youtube':
            case 'youtu':
                $sClass = (new Api\Youtube)->getVideo($sUrl);
            break;

            case 'vimeo':
                $sClass = (new Api\Vimeo)->getVideo($sUrl);
            break;

            case 'dailymotion':
                $sClass = (new Api\Dailymotion)->getVideo($sUrl);
            break;

            case 'metacafe':
                $sClass = (new Api\Metacafe)->getVideo($sUrl);
            break;

            default:
                return false;
        }

        return $sClass;
    }

    /**
     * @param string $sUrl
     * @return object Class
     * @throws \PH7\Framework\Error\CException\PH7InvalidArgumentException If the Api Video is invalid.
     */
    public function getInfo($sUrl)
    {
        $sClass = $this->clear($sUrl);

        switch ($sClass)
        {
            case 'youtube':
            case 'youtu':
                $sClass = (new Api\Youtube)->getInfo($sUrl);
            break;

            case 'vimeo':
                $sClass = (new Api\Vimeo)->getInfo($sUrl);
            break;

            case 'dailymotion':
                $sClass = (new Api\Dailymotion)->getInfo($sUrl);
            break;

            case 'metacafe':
                $sClass = (new Api\Metacafe)->getInfo($sUrl);
            break;

            default:
                throw new \PH7\Framework\Error\CException\PH7InvalidArgumentException('Invalid Api Video Type! Bad Type is: \''  . $sClass . '\'');
                return; // Stop it
        }

        return $sClass;
    }

    /**
     * @param string $sUrl
     * @param string $sMedia (preview or movie)
     * @param integer $iWidth
     * @param integer $iHeight
     * @return object Class
     * @throws \PH7\Framework\Error\CException\PH7InvalidArgumentException If the Video Api is invalid.
     */
    public function getMeta($sUrl, $sMedia, $iWidth, $iHeight)
    {
        $sClass = $this->clear($sUrl);

        $sMedia = ( isset($sMedia) ? $sMedia : 'movie' );
        $iWidth = ( isset($iWidth) ? $iWidth : $this->iWidth );
        $iHeight = (isset($iHeight) ? $iHeight : $this->iHeight );

        switch ($sClass)
        {
            case 'youtube':
            case 'youtu':
                $sClass = (new Api\Youtube)->getMeta($sUrl, $sMedia, $iWidth, $iHeight);
            break;

            case 'vimeo':
                $sClass = (new Api\Vimeo)->getMeta($sUrl, $sMedia, $iWidth, $iHeight);
            break;

            case 'dailymotion':
                $sClass = (new Api\Dailymotion)->getMeta($sUrl, $sMedia, $iWidth, $iHeight);
            break;

            case 'metacafe':
                $sClass = (new Api\Metacafe)->getMeta($sUrl, $sMedia, $iWidth, $iHeight);
            break;

            default:
                throw new \PH7\Framework\Error\CException\PH7InvalidArgumentException('Invalid Api Video Type! Bad Type is: \''  . $sClass . '\'');
        }

        return $sClass;
    }

    /**
     * @access protected
     * @param string $sUrl
     * @return string
     */
    protected function clear($sUrl)
    {
        $oHttp = new Http;
        if ($oHttp->detectSubdomain($sUrl))
        {
            // Removes the subdomain with its dot (e.g. mysub.domain.com becomes domain.com).
            $sUrl = str_replace($oHttp->getSubdomain($sUrl) . PH7_DOT, '', $sUrl);
        }
        unset($oHttp);

        return preg_replace('#(^https?://|www\.|\.[a-z]{2,4}/?(.+)?$)#i', '', $sUrl);
    }

}
