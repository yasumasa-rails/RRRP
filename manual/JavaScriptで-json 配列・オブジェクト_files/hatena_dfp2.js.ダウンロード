var hatenadfp = hatenadfp || {};
hatenadfp._startTime = new Date().getTime();
hatenadfp.adUnits = hatenadfp.adUnits || [];

var googletag = googletag || {};
googletag.cmd = googletag.cmd || [];

hatenadfp.debug = hatenadfp.debug || false;

hatenadfp.isNGContent = typeof hatenadfp.isNGContent !== 'undefined' ? hatenadfp.isNGContent : function () {
    return false;
};

hatenadfp.enableSingleRequest = hatenadfp.enableSingleRequest || false;

hatenadfp.slotRenderEndedCallback = hatenadfp.slotRenderEndedCallback || function (event) {
    if (hatenadfp.debug || window.location.search.match('hatena_dfp_debug=1')) {
        console.log( 'Slot ' + event.slot.getAdUnitPath() + ' has been rendered in '
            + (new Date().getTime() - hatenadfp._startTime) + ' msec, with' +
            ' size: ' + event.size,
            ' creativeID: ' + event.creativeId +
            ' isEmpty: ' + event.isEmpty +
            ' lineItemId: ' + event.lineItemId +
            ' serviceName: ' + event.serviceName );
    }
};

hatenadfp._hasContentMatch = false;
for (var i = 0; i < hatenadfp.adUnits.length; i++) {
    if (hatenadfp.adUnits[i].allowContentMatch) {
        hatenadfp._hasContentMatch = true;
        break;
    }
}

hatenadfp._addScript = function(url, callback) {
    var script = document.createElement("script");
    script.async = true;
    script.type = "text/javascript";
    script.src = url;
    if (typeof(callback) === 'function') {
        if (script.addEventListener) {
            script.addEventListener('load', callback);
        } else if (script.readyState) {
            script.onreadystatechange = callback;
        }
    }
    var node = document.getElementsByTagName("script")[0];
    node.parentNode.insertBefore(script, node);
};

hatenadfp._extractContent = function() {
    if (hatenadfp._pageText !== undefined) {
        return hatenadfp._pageText;
    }

    var selectors = [
        '#page-keyword div.keyword-body', /* keyword PC */
        '#question-content-container', /* question PC */
        '#hatena-anond div.section',  /* anond PC */
        '#news-container #entry-wrapper', /* bnews PC */
        '#news-container div.top-news', /* bnews PC top */
        '#hatena-www #s-bookmark', /* www top */
        '#hatena-bookmark-touch-index ul.list.entrylist', /* bookmark touch top */
        'div.section.entry-detail', /* bookmark touch entry */
        'div.entry-contents', /* bookmark PC */
        'div#page-content', /* bookmark userpage PC */
        'div.center-container', /* bookmark userpage PC v4 */
        'div.touch-articles', /* bookmark userpage touch v4 */
        'div#hatena-body div.main', /* bookmark user PC */
        'article div.entry-content', /* blog PC, blog touch */
        'article section.keyword-body', /* keyword touch */
        'div.day div.body div.section', /* diary PC */
        '#container div.section' /* anond touch */
    ];

    var contentNode = document.querySelector(selectors.join(',')) ||
        document.querySelectorAll('div.body div.section')[1] || /* diary touch */
        document.documentElement;

    var text = contentNode.innerHTML;

    text = text.replace(/\s+/g, ' ');
    text = text.replace(/<(script|noscript|style|iframe|select|blockquote|code|pre)[^>]*>.*?<\/\1>/ig, '');
    text = text.replace(/<a[^>]*>https?:\/\/.*?<\/a>/ig, '');
    text = text.replace(/\s*<("[^"]*"|'[^']*'|[^'">])*>\s*/g, '')
    text = text.replace(/[Ａ-Ｚａ-ｚ０-９]/g, function(s) { return String.fromCharCode(s.charCodeAt(0) - 0xFEE0) });

    hatenadfp._pageText = text;

    return text;
};

hatenadfp.displayAdsWithContentMatch = function (config) {
    if (hatenadfp.contentMatchWaitSelector && !document.querySelector(hatenadfp.contentMatchWaitSelector)) {
        (function (config) {
            setTimeout(hatenadfp.displayAdsWithContentMatch, 50, config);
        })(config);
        return;
    }

    var content = hatenadfp._extractContent();

    var scoresOfConfigs = new Array(config.contentMatchConfigs.length);
    for (var i = 0; i < config.contentMatchConfigs.length; i++) {
        var csvKeywordStr = config.contentMatchConfigs[i].keywords;
        csvKeywordStr = csvKeywordStr.replace(/[Ａ-Ｚａ-ｚ０-９]/g, function(s) {
            return String.fromCharCode(s.charCodeAt(0) - 0xFEE0)
        });
        var keywords = csvKeywordStr.split(',');
        var validKeywords = [];
        for (var j = 0; j < keywords.length; j++) {
            if(keywords[j].length > 0) {
                validKeywords.push(keywords[j]);
            }
        }
        var regexp = hatenadfp._regExpFromKeywords(validKeywords);
        scoresOfConfigs[i] = 0;
        while(regexp.exec(content)) {
            scoresOfConfigs[i]++;
        }
    }

    /* 複数のコンテンツマッチ枠がマッチすることを考慮して、得たスコアに応じて確率的に広告を出す */
    var totalScore = 0;
    for (var i = 0; i < scoresOfConfigs.length; i++) {
        totalScore += scoresOfConfigs[i];
    }
    /* キーワードを含まない時に広告をだす場合 */
    /* マッチした場合はscoreを0に、マッチしない場合は平均値をscoreとして与える */
    var avgScore = Math.floor(totalScore / scoresOfConfigs.length);
    if ( avgScore === 0 ) avgScore = 1;
    for (var i = 0; i < scoresOfConfigs.length; i++) {
        if ( !!config.contentMatchConfigs[i].rejects_match ) {
            if ( scoresOfConfigs[i] === 0 ) {
                totalScore += avgScore;
                scoresOfConfigs[i] = avgScore;
            } else {
                totalScore -= scoresOfConfigs[i];
                scoresOfConfigs[i] = 0;
            }
        }
    }

    var targetValue = Math.floor(Math.random() * totalScore);

    var targetConfigIndex;
    var valueRangeStart = 0;
    for (var i = 0; i < scoresOfConfigs.length; i++) {
        if (targetValue >= valueRangeStart && targetValue < valueRangeStart + scoresOfConfigs[i]) {
            targetConfigIndex = i;
            break;
        } else {
            valueRangeStart += scoresOfConfigs[i];
        }
    }

    hatenadfp._contentMatchedUnitName = targetConfigIndex !== undefined
        ? config.contentMatchConfigs[targetConfigIndex].dfp_channel
        : null;

    if (targetConfigIndex !== undefined && config.contentMatchConfigs[targetConfigIndex].div_ids) {
        var targetDivIds = config.contentMatchConfigs[targetConfigIndex].div_ids.split(',');
        if (targetDivIds.length > 0) {
            var targetDivIdMap = {};
            for (var i = 0; i < targetDivIds.length; i++) {
                targetDivIdMap[targetDivIds[i]] = true;
            }
            hatenadfp._contentMatchTargetDivIdMap = targetDivIdMap;
        }
    }

    googletag.cmd.push(hatenadfp.displayAds);
};

hatenadfp.displayAds = function() {
    googletag.pubads().setTargeting('domain', window.location.hostname);
    if (window.location.hostname.indexOf('.dev.hatena.ne.jp') > -1) {
        googletag.pubads().setTargeting('devhost', 'true');
    }
    var targetingKeyValuesMap = {};
    for (var clientName in hatenadfp._clientDfpTargetingKeyNameMap) {
        var internalClientName = clientName === 'fout' ? 'atrae' : clientName;
        var segmentIds = hatenadfp._getSegmentIdsForClient(internalClientName);
        var targetingKey = hatenadfp._clientDfpTargetingKeyNameMap[internalClientName];
        if (targetingKeyValuesMap[targetingKey] === undefined) {
            targetingKeyValuesMap[targetingKey] = [];
        }
        targetingKeyValuesMap[targetingKey].push.apply(targetingKeyValuesMap[targetingKey], segmentIds);
    }
    for (var targetingKey in targetingKeyValuesMap) {
        if (targetingKeyValuesMap[targetingKey].length > 0) {
            googletag.pubads().setTargeting(targetingKey, targetingKeyValuesMap[targetingKey]);
        }
    }
    if (hatenadfp._dgMatchedSegments && hatenadfp._dgMatchedSegments.length > 0) {
        googletag.pubads().setTargeting('dg_segments', hatenadfp._dgMatchedSegments);
    }

    googletag.pubads().addEventListener('slotRenderEnded', hatenadfp.slotRenderEndedCallback);
    if (hatenadfp.enableSingleRequest) {
        googletag.pubads().enableSingleRequest();
    }
    if (hatenadfp.centerAds !== undefined) {
        googletag.pubads().setCentering(hatenadfp.centerAds);
    }
    if (hatenadfp.collapseEmptyDivs) {
        googletag.pubads().collapseEmptyDivs();
    }

    for (var i = 0; i < hatenadfp.adUnits.length; i++) {
        var adUnit = hatenadfp.adUnits[i];
        var adUnitSizes = [];
        var hasFluid;
        /* adUnit.size は [300,250] または [[338,280],[300,250]] あるいは ['fluid', [300,100]] または単に'fluid' のような指定を受け付ける。
           広告がサイズ 'fluid' で表示されるとき、コンテンツマッチが発動しない。(同じページの他の枠は発動しうる)。
           またページコンテンツがのNGときの代替広告指定が効かず、そのまま表示される(なのでテンプレート側で広告の呼び出し自体をしない必要がある)。 */

        if (adUnit.size === 'fluid') {
            hasFluid = true;
        } else if (/_sp_/.test(adUnit.unitName) && typeof(adUnit.size[0]) === 'object') {
            var browserWidth = window.innerWidth;
            for (var j = 0; j < adUnit.size.length; j++) {
                if (typeof(adUnit.size[j]) === 'object' && adUnit.size[j][0] + 20 <= browserWidth) {
                    adUnitSizes.push(adUnit.size[j]);
                } else if (adUnit.size[j] === 'fluid') {
                    hasFluid = true;
                }
            }
        } else {
            adUnitSizes = adUnit.size;
        }
        if (hasFluid) {
            adUnitSizes = adUnit.size;
        } else if (adUnitSizes.length == 0) {
            adUnitSizes = typeof(adUnit.size[0]) === 'object' ? adUnit.size : [adUnit.size];
        }

        if (typeof(hatenadfp.isNGContent) === 'function' ? hatenadfp.isNGContent() : hatenadfp.isNGContent) {
            adUnit.unitName = 'NG';
        } else if (adUnit.allowContentMatch &&
                   hatenadfp._contentMatchedUnitName &&
                   !hasFluid &&
                   (hatenadfp._contentMatchTargetDivIdMap === undefined ||
                    hatenadfp._contentMatchTargetDivIdMap[adUnit.divId])) {
            adUnit.unitName = hatenadfp._contentMatchedUnitName;
        }
        googletag.defineSlot('/4374287/' + adUnit.unitName, adUnitSizes, adUnit.divId).addService(googletag.pubads());

    }

    googletag.enableServices();

    /* ChromeのiOS版において、以下のMutationObserverを使った処理がページロード時の
       フリーズの原因になることがあった。そのため、Android版も含め、スマートフォン・タブレット向けの
       Chromeでは、MutationObserverが存在しても利用せず、これを使用しない処理にフォールバックする。 */
    if (window.MutationObserver && !window.navigator.userAgent.match(/(?:Android.+Chrome|CriOS)/)) {
        var observer = new MutationObserver(function(mutations) {
            var shouldWaitForMoreAdUnits = false;
            for (var i = 0; i < hatenadfp.adUnits.length; i++) {
                var adUnit = hatenadfp.adUnits[i];
                // displayed は表示済みの場合以外に、利用側で googletag.display() を呼ぶタイミングを
                // 制御したい時に予め真値がセットされていることがある
                if (!adUnit.displayed) {
                    if (document.getElementById(adUnit.divId)) {
                        googletag.display(adUnit.divId);
                        adUnit.displayed = true;
                    } else {
                        shouldWaitForMoreAdUnits = true;
                    }
                }
            }
            if (!shouldWaitForMoreAdUnits) {
                observer.disconnect();
            }
        });
        observer.observe(document, { childList: true, subtree: true });
    } else {
        googletag.cmd.push(function() {
            for (var i = 0; i < hatenadfp.adUnits.length; i++) {
                (function(adUnit) {
                    if (!adUnit.displayed){
                        if (document.getElementById(adUnit.divId)) {
                            googletag.display(adUnit.divId);
                            adUnit.displayed = true;
                        } else {
                            hatenadfp._onPageLoadComplete(function () {
                                googletag.display(adUnit.divId);
                                adUnit.displayed = true;
                            });
                        }
                    }
                })(hatenadfp.adUnits[i]);
            }
        });
    }
};

hatenadfp._onPageLoadComplete = function (func) {
    if (document.addEventListener) {
        document.addEventListener('DOMContentLoaded', function() {
            func();
        }, false);
    } else if (document.attachEvent) {
        document.attachEvent('onload', function() {
            func();
        });
    }
};

hatenadfp.getCookie = function (key) {
  var counter, _key, _val, cookies = document.cookie.split(";");
  for (counter = 0; counter < cookies.length; counter++) {
    if (_key = cookies[counter].substr(0, cookies[counter].indexOf("=")),
    _val = cookies[counter].substr(cookies[counter].indexOf("=") + 1),
    _key = _key.replace(/^\s+|\s+$/g, ""),
    _key === key) return unescape(_val);
  }
};

hatenadfp.setCookie = function(key, value, expire) {
    var d = new Date();
    d.setDate(d.getDate() + expire);
    value = escape(value) + "; domain=.hatena.ne.jp; path=/" + (null === expire ? "" : "; expires=" + d.toUTCString());
    document.cookie = key + "=" + value;
};

hatenadfp._getSyncSegmentIds = function () {
    var cookieEntryStr = hatenadfp.getCookie("_fout_segment");
    return cookieEntryStr !== undefined ? cookieEntryStr.split(",") : [];
};

hatenadfp._getAllSegmentIds = function () {
    var segmentIds = [];
    ['_fout_segment', '_nttcom_segment', '_vsn_segment', '_cri_segment', '_bsa_segment',
     '_recruit_birth_segment', '_recruit_startup_segment', '_recruit_it_segment'].forEach(function(key) {
        var cookieEntryStr = hatenadfp.getCookie(key);
        if (cookieEntryStr === undefined) return;
        segmentIds = segmentIds.concat(cookieEntryStr.split(","));
    });
    return segmentIds;
};
hatenadfp._getSegmentIdsForClient = function (clientName) {
    var segmentIds = [];
    if (clientName === 'atrae') {
        clientName = 'fout';
    }
    var cookieEntryStr = hatenadfp.getCookie('_' + clientName + '_segment');
    if (cookieEntryStr === undefined) return;
    segmentIds = segmentIds.concat(cookieEntryStr.split(","));
    return segmentIds;
};

hatenadfp._regExpFromKeywords = function(keywords) {
    var escapedKeywords = [];
    for (var i = 0; i < keywords.length; i++) {
        escapedKeywords.push(keywords[i].replace(/([.*+?^=!:${}()|[\]\/\\])/g, "\\$1"));
    }
    return new RegExp('(' + escapedKeywords.join('|') + ')', 'ig');
};

hatenadfp._regExpFromKeywordsWithWordBoundary = function(keywords) {
    var escapedKeywords = [];
    for (var i = 0; i < keywords.length; i++) {
        var escaped = keywords[i].replace(/([.*+?^=!:${}()|[\]\/\\])/g, "\\$1");
        if (/^\w+$/.test(keywords[i])) {
            escaped = '\\b' + escaped + '\\b';
        }
        escapedKeywords.push(escaped);
    }
    return new RegExp('(' + escapedKeywords.join('|') + ')', 'ig');
};

hatenadfp._keywordSegmentIdMap = {
    'atrae': {
        'java': 83206,
        'ruby': 83207,
        'php': 83208,
        'perl': 83209,
        'objective-c': 83210,
        'javascript': 83211,
        'html5': 83212,
        'ios': 83213,
        'iphone': 83214,
        'android': 83215,
        'oracle': 83216,
        'mysql': 83217,
        'インフラ': 83218,
        'クラウド': 83219,
        'プログラミング': 83220
    },
    'nttcom': {
        'アプリ開発': 36000,
        'object-c': 36000,
        'java': 36000,
        'java ee': 36000,
        'asp.net mvc': 36000,
        'ruby on rails': 36000,
        'php': 36000,
        'struts': 36000,
        'play': 36000,
        'node.js': 36000,
        '.net': 36000,
        'perl': 36000,
        'c#': 36000,
        'python': 36000,
        'c++': 36000,
        'c+': 36000,
        'ruby': 36000,
        'objective-C': 36000,
        'javascript': 36000,
        'coffeescript': 36000,
        'mysql': 36000,
        'プログラミング': 36000,
        'エンジニア': 36000
    },
    'vsn': {
        'java': 37000,
        'ruby': 37000,
        'php': 37000,
        'perl': 37000,
        'objective-C': 37000,
        'javascript': 37000,
        'html5': 37000,
        'ios': 37000,
        'iphone': 37000,
        'android': 37000,
        'oracle': 37000,
        'mySQL': 37000,
        'インフラ': 37000,
        'クラウド': 37000,
        'プログラミング': 37000,
        'cad': 37000,
        'cobol': 37000,
        'cr5000': 37000,
        'dbms': 37000,
        'fpga': 37000,
        'http': 37000,
        'lsiレイアウト': 37000,
        'mcframe': 37000,
        'oracleebs': 37000,
        'pcb処理': 37000,
        'plcプログラム': 37000,
        'verilog': 37000
    },
    'cri': {
        '求人': 38000,
        '求人サイト': 38001,
        '転職': 38002,
        '転職サイト': 38003,
        '正社員': 38004,
        '契約社員': 38005,
        'フリーランス': 38006,
        '求人情報': 38007,
        'デザイナー求人': 38008,
        'デザイナー転職': 38009,
        'webデザイナー求人': 38010,
        'webデザイナー転職': 38011,
        'web業界求人': 38012,
        'web業界転職': 38013,
        'ウェブ制作会社': 38014,
        'web制作会社': 38015,
        'ウェブデザイナー': 38016,
        'webデザイナー': 38017,
        'ウェブ業界': 38018,
        'web業界': 38019,
        'ウェブサイトデザイン': 38020,
        'webサイトデザイン': 38021,
        'モバイル業界': 38022,
        'ウェブディレクター': 38023,
        'webディレクター': 38024,
        'インフォメーションアーキテクト': 38025,
        'uxデザイナー': 38026,
        'uiデザイナー': 38027,
        'ux・uiデザイナー': 38028,
        'htmlコーダー': 38029,
        'コーダー': 38030,
        'webマーケティング': 38031,
        'ウェブマーケティング': 38032,
        'デザイン事務所': 38033
    }
};

hatenadfp._clientDfpTargetingKeyNameMap = {
    'atrae': 'IT',
    'nttcom': 'IT',
    'vsn': 'IT',
    'cri': '求人'
};

hatenadfp._intimateMergerKeywords = [ 'JavaScript', 'Linux', 'Java', 'PHP', 'Ruby', 'Python', 'iOS', 'CSS', 'HTML', 'CentOS', 'jQuery', 'Git', 'MySQL', 'Ubuntu', 'C#', 'Rails', 'Node.js', 'C++', 'Swift', 'Xcode', 'GitHub', 'Objective-C', 'ShellScript', 'HTML5', 'Vim', 'MacOSX', 'Apache', 'CSS3', 'SSH', 'nginx', '正規表現', 'Zsh', 'Scala', 'Perl', 'Qiita', 'CoffeeScript', 'Heroku', 'Emacs', 'MongoDB', 'Haskell', 'TDD', 'Backbone.js', 'Scheme', '情報システム', '人月', '要件定義', '仕様設計', 'ERP', 'SAP', '上流工程', 'システム統合', 'ウォーターフォール', 'アジャイル', 'オフショア', 'デスマーチ', 'オフショア開発', '工数管理', 'システムインテグレーター', 'SIer' ];

hatenadfp._enhanceKeywords = [
    'Ruby', 'システムエンジニア', 'iOS', 'iPhone', 'CentOS', 'Android', 'Mac', 'JavaScript', 'Java', '英語', 'Qiita', 'Linux', 'Git', 'Chrome', '転職', '自動車', 'PHP', 'Python', 'HTML', 'Twitter', 'MySQL', 'GitHub', 'CSS', 'jQuery', 'Ubuntu', 'Rails', '資格', 'Vim', 'SSH', 'Perl', 'C#', 'Apache', '正規表現', 'SIer', 'Scala', 'ERP', 'Swift', 'HTML5', 'Facebook', 'Emacs', 'Node.js', 'nginx', 'アジャイル', 'オフショア', '情報システム', 'Xcode', 'SAP', 'Haskell', 'CSS3', 'Zsh', 'Heroku', 'Objective-C', 'MongoDB', 'デスマーチ', 'MacOSX', 'Scheme', 'CoffeeScript', '要件定義', 'ウォーターフォール', 'オフショア開発', 'システムインテグレータ', '人月', '上流工程', '工数管理', 'システム統合',
    'サッカー日本代表', 'サッカー', 'ワールドカップ予選', 'ワールドカップ',
    'AI', 'IoT', 'ロボット',
    'おむつ', '妊活', '基礎体温', '初産', '出産', 'マタニティグッズ', 'マタニティ', '不妊', '妊婦', 'ワークライフバランス', 'イクメン', '産休', '出産準備', '体外受精', '時短レシピ', 'ベビーベット', '抱っこ紐', 'キャラ弁', 'キャラ弁レシピ', '母乳',
    '知育', '小学校受験', 'お受験', '中学受験', 'ランドセル', '運動会', 'PTA', 'お弁当',
    '株式', '時価総額', 'FX', '為替', '確定拠出年金', '損切り', '資産', '株価', '証券', '確定申告', '貯蓄', 'ふるさと納税', '投資', '円高', '円安', 'ビットコイン', 'IPO', '上場', '米国株', 'ETF', '副業', '配当', '不労所得', 'ファンド', '仮想通貨', 'ブックビルディング', 'マネーセミナー', '投信',
    'VOD', 'オンデマンド', '海外ドラマ', '韓国ドラマ', '動画配信', 'オリジナルドラマ', '映像見放題', '動画見放題', 'ビデオレンタル',
    '賃貸', '家賃', '敷金', '礼金', '1人暮らし', '仲介手数料', '引越', '築年数', 'シェアハウス', '新築', '築浅', 'レインズ', 'REINS',
    'マーケティング', 'マーケター', 'マーケッター', '広告宣伝', '商品開発', 'プロダクト', 'MAツール', '顧客', 'ブランディング', 'ストラテジー', '市場調査', 'ソーシャル活用', 'アドテク', 'DMP', 'DSP', 'アドネットワーク', 'RTB', 'オーディエンスデータ', 'Facebook広告', 'Twitter広告', 'リスティング', 'SEO', 'オムニチャネル', 'Googleアナリティクス', 'コンバージョン', '動画広告', 'オウンドメディア', 'コトラー', 'MBA', 'プロモーション', 'KPI',
    '情シス', '情報システム', '社内SE', 'DB設計', 'グループウェア', '基幹システム', '社内インフラ', '社内サーバ', 'イントラネット', 'IT部門',
    'ブラックカード', '会員制', 'ゴルフ', '資産運用'
];

hatenadfp._enhanceKeywordJpToAlnumMap = {
    '英語': 'English',
    '転職': 'JobChange',
    '自動車': 'Automobile',
    '資格': 'Qualification',
    '正規表現': 'RegularExpression',
    'アジャイル': 'AgileSoftwareDevelopment',
    'オフショア': 'Offshore',
    '情報システム': 'InformationSystem',
    'デスマーチ': 'DeathMarch',
    '要件定義': 'RequirementDefinition',
    'ウォーターフォール': 'WaterfallModel',
    'オフショア開発': 'OffshoreDevelopment',
    'システムインテグレータ': 'SystemIntegrator',
    '人月': 'ManMonth',
    '上流工程': 'UpstreamProcess',
    '工数管理': 'ManhourControl',
    'システム統合': 'SystemIntegration',

    'システムエンジニア': 'SystemEngineer',

    'サッカー日本代表': 'JapanNationalFootballTeam',
    'サッカー': 'Football',
    'ワールドカップ予選': 'WorldCupQualifier',
    'ワールドカップ': 'WorldCup',

    'c#': 'CSharp',
    'objective-c': 'ObjectiveC',
    'node.js': 'NodeJS',

    'ロボット': 'Robot',

    'おむつ': 'Diapers',
    '妊活': 'Pregnancy',
    '基礎体温': 'BodyTemperature',
    '初産': 'FirstBirth',
    '出産': 'Birth',
    'マタニティグッズ': 'MaternityGoods',
    'マタニティ': 'Maternity',
    '不妊': 'Infertility',
    '妊婦': 'PregnantWomen',
    'ワークライフバランス': 'WorkLifeBalance',
    'イクメン': 'Ikumen',
    '産休': 'MaternityLeave',
    '出産準備': 'PrepareBirth',
    '体外受精': 'InVitroFertilization',
    '時短レシピ': 'ShortRecipe',
    'ベビーベット': 'BabyBed',
    '抱っこ紐': 'HugString',
    'キャラ弁': 'CharacterBoxLunch',
    'キャラ弁レシピ': 'CharacterBoxLunchRecipe',
    '母乳': 'BreastMilk',

    '知育': 'IntellectualTraining',
    '小学校受験': 'ElementarySchoolExamination',
    'お受験': 'Examination',
    '中学受験': 'JuniorHighSchoolExamination',
    'ランドセル': 'SchoolBag',
    '運動会': 'Sportsday',
    'お弁当': 'BoxLunch',

    '株式': 'Stock',
    '時価総額': 'MarketCapitalization',
    '為替': 'Exchange',
    '確定拠出年金': 'DefinedContributionPension',
    '損切り': 'LossOfCut',
    '資産': 'Asset',
    '株価': 'StockPrice',
    '証券': 'Securities',
    '確定申告': 'TaxReturn',
    '貯蓄': 'Savings',
    'ふるさと納税': 'FurusatoTaxPayment',
    '投資': 'Investment',
    '円高': 'YenAppreciation',
    '円安': 'YenDepreciation',
    'ビットコイン': 'BitCoin',
    '上場': 'Listing',
    '米国株': 'USStock',
    '副業': 'SideJob',
    '配当': 'Dividend',
    '不労所得' : 'UnemploymentIncome',
    'ファンド': 'Fund',
    '仮想通貨': 'VirtualCurrency',
    'ブックビルディング': 'BookBuilding',
    'マネーセミナー': 'MoneySeminar',
    '投信': 'InvestmentTrust',

    'オンデマンド': 'OnDemand',
    '海外ドラマ': 'ForeignDrama',
    '韓国ドラマ': 'KoreanDrama',
    '動画配信': 'VideoDistribution',
    'オリジナルドラマ': 'OriginalDrama',
    '映像見放題': 'VODUnlimited',
    '動画見放題': 'VODUnlimited',
    'ビデオレンタル': 'VideoRental',

    '賃貸': 'Lease',
    '家賃': 'Lent',
    '敷金': 'Deposit',
    '礼金': 'KeyMoney',
    '1人暮らし': 'OnePersonLiving',
    '仲介手数料': 'BrokerageFee',
    '引越': 'Moving',
    '築年数': 'HouseAge',
    'シェアハウス': 'ShareHouse',
    '新築': 'NewConstruction',
    '築浅': 'RelativelyNewBuilding',
    'レインズ': 'Reins',

    'マーケティング': 'Marketing',
    'マーケター': 'Marketer',
    'マーケッター': 'Marketer',
    '広告宣伝': 'Advertisement',
    '商品開発': 'ProductDevelopment',
    'プロダクト': 'Product',
    'maツール': 'MATool',
    '顧客': 'Client',
    'ブランディング': 'Branding',
    'ストラテジー': 'Strategy',
    '市場調査': 'MarketResearch',
    'ソーシャル活用': 'SocialUtilization',
    'アドテク': 'AdTech',
    'アドネットワーク': 'AdNetwork',
    'オーディエンスデータ': 'AudienceData',
    'facebook広告': 'FacebookAd',
    'twitter広告': 'TwitterAd',
    'リスティング': 'Listing',
    'オムニチャネル': 'OmniChannel',
    'googleアナリティクス': 'GoogleAnalytics',
    'コンバージョン': 'Conversion',
    '動画広告': 'VideoAd',
    'オウンドメディア': 'OwnedMedia',
    'コトラー': 'Cotler',
    'プロモーション': 'Promotion',

    '情シス': 'InformationSystem',
    '情報システム': 'InformationSystem',
    '社内se': 'InhouseSE',
    'db設計': 'DatabaseDesign',
    'グループウェア': 'Groupware',
    '基幹システム': 'CoreSystem',
    '社内インフラ': 'OnPremiseInfrastructure',
    '社内サーバ': 'OnPremiseServer',
    'イントラネット': 'Intranet',
    'it部門': 'ITDepartment',

    'ブラックカード': 'BlackCard',
    '会員制': 'MemberOnly',
    'ゴルフ': 'Golf',
    '資産運用': 'AssetManagement'
};

hatenadfp._enhanceKeywordToAlnum = function(matchedKeywordLowerCase) {
    if (matchedKeywordLowerCase in hatenadfp._enhanceKeywordJpToAlnumMap) {
        return hatenadfp._enhanceKeywordJpToAlnumMap[matchedKeywordLowerCase];
    } else {
        return matchedKeywordLowerCase;
    }
};

hatenadfp._mynaviKeywords = [
    'Ruby', 'CentOS', 'JavaScript', 'Java', '英語', 'Qiita', 'Linux', 'Git', '転職', '自動車', 'PHP', 'Python', 'HTML', 'MySQL', 'GitHub', 'CSS', 'jQuery', 'Ubuntu', 'Rails', '資格', 'Vim', 'C#', 'SSH', 'Perl', 'Apache', '正規表現', 'SIer', 'Scala', 'ERP', 'Swift', 'HTML5', 'Emacs', 'Node.js', 'nginx', 'アジャイル', 'オフショア', '情報システム', 'Xcode', 'SAP', 'Haskell', 'CSS3', 'Zsh', 'Heroku', 'Objective-C', 'MongoDB', 'デスマーチ',  'CoffeeScript', '要件定義', 'ウォーターフォール', 'オフショア開発', 'システムインテグレータ', '人月', '上流工程', '工数管理', 'システム統合',
    'サッカー日本代表', 'ワールドカップ予選',
    'AI', 'IoT', 'ロボット',
    'おむつ', '妊活', '基礎体温', '初産', '出産', 'マタニティグッズ', 'マタニティ', '不妊', '妊婦', 'ワークライフバランス', 'イクメン', '産休', '出産準備', '体外受精', '時短レシピ', 'ベビーベット', '抱っこ紐', 'キャラ弁', 'キャラ弁レシピ', '母乳',
    '知育', '小学校受験', 'お受験', '中学受験', 'ランドセル', '運動会', 'PTA', 'お弁当',
    '株式', '時価総額', 'FX', '為替', '確定拠出年金', '損切り', '資産', '株価', '証券', '確定申告', '貯蓄', 'ふるさと納税', '投資', '円高', '円安', 'ビットコイン', 'IPO', '上場', '米国株', 'ETF', '副業', '配当', '不労所得', 'ファンド', '仮想通貨', 'ブックビルディング', 'マネーセミナー', '投信',
    'VOD', 'オンデマンド', '海外ドラマ', '韓国ドラマ', '動画配信', 'オリジナルドラマ', '映像見放題', '動画見放題', 'ビデオレンタル',
    '賃貸', '家賃', '敷金', '礼金', '1人暮らし', '仲介手数料', '引越', '築年数', 'シェアハウス', '新築', '築浅', 'レインズ', 'REINS',
    'マーケティング', 'マーケター', 'マーケッター', '広告宣伝', '商品開発', 'プロダクト', 'MAツール', '顧客', 'ブランディング', 'ストラテジー', '市場調査', 'ソーシャル活用', 'アドテク', 'DMP', 'DSP', 'アドネットワーク', 'RTB', 'オーディエンスデータ', 'Facebook広告', 'Twitter広告', 'リスティング', 'SEO', 'オムニチャネル', 'Googleアナリティクス', 'コンバージョン', '動画広告', 'オウンドメディア', 'コトラー', 'MBA', 'プロモーション', 'KPI',
    '情シス', '情報システム', '社内SE', 'DB設計', 'グループウェア', '基幹システム', '社内インフラ', '社内サーバ', 'イントラネット', 'IT部門',
    'ブラックカード',
    'シェルスクリプト', 'tdd'
];

hatenadfp._mynaviKeywordsJpToAlnumMap = {
    '英語': 'English',
    '転職': 'JobChange',
    '自動車': 'Automobile',
    '資格': 'Qualification',
    '正規表現': 'RegularExpression',
    'アジャイル': 'AgileSoftwareDevelopment',
    'オフショア': 'Offshore',
    '情報システム': 'InformationSystem',
    'デスマーチ': 'DeathMarch',
    '要件定義': 'RequirementDefinition',
    'ウォーターフォール': 'WaterfallModel',
    'オフショア開発': 'OffshoreDevelopment',
    'システムインテグレータ': 'SystemIntegrator',
    '人月': 'ManMonth',
    '上流工程': 'UpstreamProcess',
    '工数管理': 'ManhourControl',
    'システム統合': 'SystemIntegration',

    'c#': 'CSharp',
    'objective-c': 'ObjectiveC',
    'node.js': 'NodeJS',

    'ロボット': 'Robot',

    'おむつ': 'Diapers',
    '妊活': 'Pregnancy',
    '基礎体温': 'BodyTemperature',
    '初産': 'FirstBirth',
    '出産': 'Birth',
    'マタニティグッズ': 'MaternityGoods',
    'マタニティ': 'Maternity',
    '不妊': 'Infertility',
    '妊婦': 'PregnantWomen',
    'ワークライフバランス': 'WorkLifeBalance',
    'イクメン': 'Ikumen',
    '産休': 'MaternityLeave',
    '出産準備': 'PrepareBirth',
    '体外受精': 'InVitroFertilization',
    '時短レシピ': 'ShortRecipe',
    'ベビーベット': 'BabyBed',
    '抱っこ紐': 'HugString',
    'キャラ弁': 'CharacterBoxLunch',
    'キャラ弁レシピ': 'CharacterBoxLunchRecipe',
    '母乳': 'BreastMilk',

    '知育': 'IntellectualTraining',
    '小学校受験': 'ElementarySchoolExamination',
    'お受験': 'Examination',
    '中学受験': 'JuniorHighSchoolExamination',
    'ランドセル': 'SchoolBag',
    '運動会': 'Sportsday',
    'お弁当': 'BoxLunch',

    '株式': 'Stock',
    '時価総額': 'MarketCapitalization',
    '為替': 'Exchange',
    '確定拠出年金': 'DefinedContributionPension',
    '損切り': 'LossOfCut',
    '資産': 'Asset',
    '株価': 'StockPrice',
    '証券': 'Securities',
    '確定申告': 'TaxReturn',
    '貯蓄': 'Savings',
    'ふるさと納税': 'FurusatoTaxPayment',
    '投資': 'Investment',
    '円高': 'YenAppreciation',
    '円安': 'YenDepreciation',
    'ビットコイン': 'BitCoin',
    '上場': 'Listing',
    '米国株': 'USStock',
    '副業': 'SideJob',
    '配当': 'Dividend',
    '不労所得' : 'UnemploymentIncome',
    'ファンド': 'Fund',
    '仮想通貨': 'VirtualCurrency',
    'ブックビルディング': 'BookBuilding',
    'マネーセミナー': 'MoneySeminar',
    '投信': 'InvestmentTrust',

    'オンデマンド': 'OnDemand',
    '海外ドラマ': 'ForeignDrama',
    '韓国ドラマ': 'KoreanDrama',
    '動画配信': 'VideoDistribution',
    'オリジナルドラマ': 'OriginalDrama',
    '映像見放題': 'VODUnlimited',
    '動画見放題': 'VODUnlimited',
    'ビデオレンタル': 'VideoRental',

    '賃貸': 'Lease',
    '家賃': 'Lent',
    '敷金': 'Deposit',
    '礼金': 'KeyMoney',
    '1人暮らし': 'OnePersonLiving',
    '仲介手数料': 'BrokerageFee',
    '引越': 'Moving',
    '築年数': 'HouseAge',
    'シェアハウス': 'ShareHouse',
    '新築': 'NewConstruction',
    '築浅': 'RelativelyNewBuilding',
    'レインズ': 'Reins',

    'マーケティング': 'Marketing',
    'マーケター': 'Marketer',
    'マーケッター': 'Marketer',
    '広告宣伝': 'Advertisement',
    '商品開発': 'ProductDevelopment',
    'プロダクト': 'Product',
    'maツール': 'MATool',
    '顧客': 'Client',
    'ブランディング': 'Branding',
    'ストラテジー': 'Strategy',
    '市場調査': 'MarketResearch',
    'ソーシャル活用': 'SocialUtilization',
    'アドテク': 'AdTech',
    'アドネットワーク': 'AdNetwork',
    'オーディエンスデータ': 'AudienceData',
    'facebook広告': 'FacebookAd',
    'twitter広告': 'TwitterAd',
    'リスティング': 'Listing',
    'オムニチャネル': 'OmniChannel',
    'googleアナリティクス': 'GoogleAnalytics',
    'コンバージョン': 'Conversion',
    '動画広告': 'VideoAd',
    'オウンドメディア': 'OwnedMedia',
    'コトラー': 'Cotler',
    'プロモーション': 'Promotion',

    '情シス': 'InformationSystem',
    '情報システム': 'InformationSystem',
    '社内se': 'InhouseSE',
    'db設計': 'DatabaseDesign',
    'グループウェア': 'Groupware',
    '基幹システム': 'CoreSystem',
    '社内インフラ': 'OnPremiseInfrastructure',
    '社内サーバ': 'OnPremiseServer',
    'イントラネット': 'Intranet',
    'it部門': 'ITDepartment',

    'シェルスクリプト': 'ShellScript',
};

hatenadfp._mynaviKeywordToAlnum = function(matchedKeywordLowerCase) {
    if (matchedKeywordLowerCase in hatenadfp._mynaviKeywordsJpToAlnumMap) {
        return hatenadfp._mynaviKeywordsJpToAlnumMap[matchedKeywordLowerCase];
    } else {
        return matchedKeywordLowerCase;
    }
};

hatenadfp._addSegmentsByKeywords = function (matchedKeywords) {
    var userSegmentIds = hatenadfp._getAllSegmentIds();
    var userSegmentIdMap = {};
    for (var i = 0; i < userSegmentIds.length; i++) {
        userSegmentIdMap[userSegmentIds[i]] = true;
    }
    for (var i = 0; i < matchedKeywords.length; i++) {
        for (var key in hatenadfp._keywordSegmentIdMap) {
            var matchedSegmentId = hatenadfp._keywordSegmentIdMap[key][matchedKeywords[i]];
            if (matchedSegmentId && userSegmentIdMap[matchedSegmentId] === undefined) {
                hatenadfp._addScript('//b.hatena.ne.jp/api/internal/v0/user.segment.json?keywords_csv=' + encodeURIComponent(matchedKeywords.join(',')));
                return;
            }
        }
    }
};

hatenadfp._assignAdTargetingSegments = function() {
    var text = hatenadfp._extractContent();

    var keywords = [];
    for (var key in hatenadfp._keywordSegmentIdMap) {
        for (var keyword in hatenadfp._keywordSegmentIdMap[key]) {
            keywords.push(hatenadfp._escapeStr(keyword));
        }
    }

    var keywordRegExp = hatenadfp._regExpFromKeywords(keywords);
    var matched = keywordRegExp.exec(text);
    var matchedKeywordMap = {};
    while(matched) {
        matchedKeywordMap[matched[0].toLowerCase()] = true;
        matched = keywordRegExp.exec(text);
    }
    var matchedKeywords = [];
    for (var keyword in matchedKeywordMap) {
        matchedKeywords.push(keyword);
    }

    if (matchedKeywords.length > 0) {
        hatenadfp._addSegmentsByKeywords(matchedKeywords);
    }

    /* BigMining / keyword segmentation */
    hatenadfp.imKeywords = [];
    var imKeywordRegExp = hatenadfp._regExpFromKeywords(hatenadfp._intimateMergerKeywords);
    var imMatchedKeywordMap = {};
    var imKeywordsMatched = imKeywordRegExp.exec(text);
    while (imKeywordsMatched) {
        imMatchedKeywordMap[imKeywordsMatched[0].toLowerCase()] = true;
        imKeywordsMatched = imKeywordRegExp.exec(text);
    }
    if (Object.keys(imMatchedKeywordMap).length > 0) {
        for (var imMatchedKeyword in imMatchedKeywordMap) {
            hatenadfp.imKeywords.push(imMatchedKeyword);
        }
        hatenadfp._addScript('//cdn.bigmining.com/private/js/hatena_bigmining.js');
    }

    /* Enhance DMP keyword segmentation */
    var enhanceKeywordRegExp = hatenadfp._regExpFromKeywordsWithWordBoundary(hatenadfp._enhanceKeywords);
    var enhanceMatchedKeywordMap = {};
    var enhanceKeywordsMatched = enhanceKeywordRegExp.exec(text);
    while (enhanceKeywordsMatched) {
        enhanceMatchedKeywordMap[enhanceKeywordsMatched[0].toLowerCase()] = true;
        enhanceKeywordsMatched = enhanceKeywordRegExp.exec(text);
    }
    if (Object.keys(enhanceMatchedKeywordMap).length > 0) {
        hatenadfp._addScript('//d-cache.microad.jp/js/td_htn_access.js', function() {
            for (var enhanceMatchedKeyword in enhanceMatchedKeywordMap) {
                enhanceTd.HTN.start({"article_category": hatenadfp._enhanceKeywordToAlnum(enhanceMatchedKeyword)});
            }
        });
    }

    /* Mynavi DMP keywords segmentation */
    var mynaviKeywordRegExp = hatenadfp._regExpFromKeywordsWithWordBoundary(hatenadfp._mynaviKeywords);
    var mynaviMatchedKeywordMap = {};
    var mynaviKeywordsMatched = mynaviKeywordRegExp.exec(text);
    while (mynaviKeywordsMatched) {
        mynaviMatchedKeywordMap[mynaviKeywordsMatched[0].toLowerCase()] = true;
        mynaviKeywordsMatched = mynaviKeywordRegExp.exec(text);
    }
    if (Object.keys(mynaviMatchedKeywordMap).length > 0) {
        var encodedKeywordParams = [];
        for (var mynaviMatchedKeyword in mynaviMatchedKeywordMap) {
            var alnumKeyword = hatenadfp._mynaviKeywordToAlnum(mynaviMatchedKeyword);
            encodedKeywordParams.push(encodeURIComponent(alnumKeyword));
        }
        hatenadfp._addScript('//dex.advg.jp/dx/p/us0?_aid=3568&keyword=' + encodedKeywordParams.join(','));
    }

    /* Intimate Merger / Hatnea login user segmentation */
    if (hatenadfp.getCookie('rk')) {
        (new Image()).src = '//atm.im-apps.net/a/beacon.gif?cid=6604&c1=1';
    }
};

hatenadfp._escapeStr = function(str) {
    return str.replace(new RegExp('[.\\\\+*?\\[\\^\\]$(){}=!<>|:\\' + '-]', 'g'), '\\$&');
};

hatenadfp._effectiveSegmentIdMap = {
    '3014': true,
    '3008': true,
    '13128': true,
    '10184': true
};

hatenadfp.presetDGSegments = function (data) {
    var segment_list = ["flzQBBzN2LI","+DgeiKxAJZk","a0l5Sjl3U64","gRTQXn9P4ts","WKeMVLxRFv4","ZcTCjTDj4F4","HeVyp8KHt9o","LGGVZUjS2Ho","IY1BMneJRrI","rzm7Hcl7mkk","UQWWkMyAOBc","JWDQFIRkyIA","n2AyesozhX4","DCPpBaiImbY","WKBn3fpj6OM","FFNd9Dk2QAg","EdpzakAtbXs","e/bCFyDhM2k","XVuxPrdCKoQ","/CdoGlkNCCM","dJIawCdqVNI","DS6qkQc/Xiw","W1/PY9mokFM","juN1q7CibZk","2Ud0dAa/Ypw","FdtNZrh0fXk","cZCAudtUf7E","okFGZfQS+9o","nvXtM/AiVYI","Mz6Z+VjaMjU","PdG0vbY0Eos","SQqURn0TlY4","BHMNVmDFGmk","NQyUoxNt1Uk","u4filJogmtY","UfOXoHC4p1o","vuv8vFjLJnk","ujXUdyD8350","s045hPTiAfQ","a4agivnpv78","Ww7vvNR8TQw","fDNurMqFi4c","l5RZQKuh8DE","GGIpcsm2JRM","P7DXf92MdgA","HxuAzYgAXJ0","1U9UZ6fa3cg","QW7r5RzfzoQ","1k1Pp2Le+1Y","r/zJLPXILts","aIasJwXRQnY"];
    var req_segment_list = [];
    for (var key in data.segment_eids) {
        if(segment_list.indexOf(data.segment_eids[key]) >= 0){
            req_segment_list.push(data.segment_eids[key]);
        }
    }
    hatenadfp._dgMatchedSegments = req_segment_list;
    hatenadfp.displayAdsMayContentMatch();

}

hatenadfp.displayAdsMayContentMatch = function () {
    if (hatenadfp._hasContentMatch) {
        hatenadfp._addScript('//b.hatena.ne.jp/api/dfp.config.json?callback=hatenadfp.displayAdsWithContentMatch');
    } else if (!hatenadfp._dgMatchedSegments) {
        hatenadfp._addScript('//sync.im-apps.net/imid/segment?token=E38WhJfqkeUxiIkb8Mzm7Q&callback=hatenadfp.presetDGSegments');
    } else {
        googletag.cmd.push(hatenadfp.displayAds);
    }
}

hatenadfp.displayAdsWithSegmentSync = function(segmentData) {
    var segmentIds = hatenadfp._getSyncSegmentIds();
    var segmentIdMap = {};
    for (var i = 0; i < segmentIds.length; i++) {
        segmentIdMap[segmentIds[i]] = true;
    }
    if(segmentData.segments !== undefined) {
        for (var j = 0; j < segmentData.segments.length; j++) {
            if (hatenadfp._effectiveSegmentIdMap[segmentData.segments[j].segment_id]) {
                segmentIdMap[segmentData.segments[j].segment_id] = true;
            }
        }
    }
    var mergedSegmentIds = [];
    for (var segmentId in segmentIdMap) {
        mergedSegmentIds.push(segmentId);
    }

    hatenadfp.setCookie('_fout_segment', mergedSegmentIds.join(','), 365);
    hatenadfp.setCookie('_fout_segment_sync', '1', 1);

    hatenadfp.displayAdsMayContentMatch();
};

// OpenX header bidding
if (hatenadfp.adUnits.length > 0) {
    var OX_dfp_options = {prefetch: true};
    var OX_dfp_ads = [];
    for (var i = 0; i < hatenadfp.adUnits.length; i++) {
        var adUnit = hatenadfp.adUnits[i];
        var oxSizes = [];
        // normalize adUnit.size structure of [[300,250], [336,280]] or [300,250] to prior.
        var sizes = typeof(adUnit.size[0]) === 'object' ? adUnit.size : [adUnit.size];
        for (var j = 0; j < sizes.length; j++) {
            if (typeof(sizes[j][0]) === 'number') { // detect 'fluid' or [300,250]
                oxSizes.push(sizes[j].join('x'));
            } else {
                oxSizes.push(sizes[j]);
            }
        }
        OX_dfp_ads.push(['/4374287/' + adUnit.unitName, oxSizes, adUnit.divId]);
    }
    hatenadfp._addScript('//hatena-d.openx.net/w/1.0/jstag?nc=4374287-hatena.ne.jp');
}

// A9 S2S header bidding
if (hatenadfp.adUnits.length > 0) {
    !function(a9,a,p,s,t,A,g){if(a[a9])return;function q(c,r){a[a9]._Q.push([c,r])}a[a9]={init:function(){q("i",arguments)},fetchBids:function()
    {q("f",arguments)},setDisplayBids:function(){},_Q:[]};A=p.createElement(s);A.async=!0;A.src=t;g=p.getElementsByTagName(s)[0];g.parentNode.insertBefore(
    A,g)}("apstag",window,document,"script","//c.amazon-adsystem.com/aax2/apstag.js");
    {
        apstag.init({
            pubID: '3466',
            adServer: 'googletag'
        });

        var a9Slots = [];
        for (var i = 0; i < hatenadfp.adUnits.length; i++) {
            var adUnit = hatenadfp.adUnits[i];
            a9Slots.push({
                slotID: adUnit.divId,
                slotName: adUnit.unitName,
                // normalize adUnit.size structure of [[300,250], [336,280]] or [300,250] to prior.
                sizes: typeof(adUnit.size[0]) === 'object' ? adUnit.size : [adUnit.size]
            });
        }

        apstag.fetchBids({
            slots: a9Slots,
            timeout: 2e3
        }, function(bids) {
            googletag.cmd.push(function(){
                apstag.setDisplayBids();
            });
        });
    }
}

if (!hatenadfp.getCookie('_fout_segment_sync')) {
    hatenadfp._addScript('//cnt.fout.jp/segapi/audience?cvid=mstR6EjxHmpIV1QDzg&callback=hatenadfp.displayAdsWithSegmentSync');
} else {
    hatenadfp.displayAdsMayContentMatch();
}

hatenadfp._addScript('//www.googletagservices.com/tag/js/gpt.js');

hatenadfp._onPageLoadComplete(hatenadfp._assignAdTargetingSegments);
