-- 经典典籍表
CREATE TABLE IF NOT EXISTS classic_book (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL, -- 典籍名称
    author TEXT, -- 作者
    dynasty TEXT, -- 朝代
    category TEXT NOT NULL, -- 分类
    intro TEXT -- 简介
);

-- 经典条文表
CREATE TABLE IF NOT EXISTS classic_text (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    book_id INTEGER NOT NULL, -- 典籍ID
    chapter TEXT, -- 章节
    section TEXT, -- 条文号
    content TEXT NOT NULL, -- 原文内容
    translation TEXT, -- 白话文翻译
    interpretation TEXT, -- 解析
    tags TEXT, -- 标签
    FOREIGN KEY (book_id) REFERENCES classic_book(id)
);

-- 中药表
CREATE TABLE IF NOT EXISTS chinese_medicine (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL, -- 中药名称
    pinyin TEXT NOT NULL, -- 拼音
    Latin TEXT, -- 拉丁名
    property TEXT, -- 性味
    channel TEXT, -- 归经
    function TEXT, -- 功效
    indication TEXT, -- 主治
    usage TEXT, -- 用法用量
    caution TEXT, -- 使用注意
    image_url TEXT -- 图片URL
);

-- 中药药证表
CREATE TABLE IF NOT EXISTS medicine_syndrome (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    medicine_id INTEGER NOT NULL, -- 中药ID
    syndrome TEXT NOT NULL, -- 药证
    FOREIGN KEY (medicine_id) REFERENCES chinese_medicine(id)
);

-- 方剂表
CREATE TABLE IF NOT EXISTS prescription (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL, -- 方剂名称
    pinyin TEXT NOT NULL, -- 拼音
    source TEXT, -- 出处
    category TEXT, -- 分类
    composition TEXT, -- 组成
    dosage TEXT, -- 用法用量
    function TEXT, -- 功用
    indication TEXT, -- 主治
    explanation TEXT, -- 方解
    syndromes TEXT -- 方证要点
);

-- 方剂组成表
CREATE TABLE IF NOT EXISTS prescription_medicine (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    prescription_id INTEGER NOT NULL, -- 方剂ID
    medicine_id INTEGER NOT NULL, -- 中药ID
    dosage TEXT NOT NULL, -- 剂量
    role TEXT, -- 君臣佐使
    FOREIGN KEY (prescription_id) REFERENCES prescription(id),
    FOREIGN KEY (medicine_id) REFERENCES chinese_medicine(id)
);

-- 类方关系表
CREATE TABLE IF NOT EXISTS prescription_relation (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    prescription_id INTEGER NOT NULL, -- 方剂ID
    related_id INTEGER NOT NULL, -- 关联方剂ID
    relation_type TEXT NOT NULL, -- 关系类型
    FOREIGN KEY (prescription_id) REFERENCES prescription(id),
    FOREIGN KEY (related_id) REFERENCES prescription(id)
);

-- 脉诊表
CREATE TABLE IF NOT EXISTS pulse_diagnosis (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL, -- 脉象名称
    pinyin TEXT NOT NULL, -- 拼音
    description TEXT NOT NULL, -- 脉象描述
    mechanism TEXT, -- 病机
    image_url TEXT, -- 图片URL
    syndromes TEXT, -- 相关证候
    prescriptions TEXT -- 相关方剂
);

-- 舌诊表
CREATE TABLE IF NOT EXISTS tongue_diagnosis (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    tongue_coating TEXT, -- 舌苔
    tongue_body TEXT, -- 舌质
    description TEXT, -- 描述
    mechanism TEXT, -- 病机
    image_url TEXT, -- 图片URL
    syndromes TEXT, -- 相关证候
    prescriptions TEXT -- 相关方剂
);

-- 测试数据
-- 经典典籍
INSERT OR IGNORE INTO classic_book (name, author, dynasty, category, intro) VALUES
('伤寒论', '张仲景', '东汉', '伤寒', '中医经典著作，创立辨证论治体系'),
('金匮要略', '张仲景', '东汉', '杂病', '论述杂病辨证论治的专著'),
('黄帝内经', '佚名', '战国至秦汉', '基础理论', '中医基础理论的奠基之作'),
('温病条辨', '吴鞠通', '清', '温病', '温病学派的代表著作，创立三焦辨证'),
('神农本草经', '佚名', '东汉', '本草', '中国第一部药学专著'),
('难经', '扁鹊', '战国', '基础理论', '中医经典著作，补充和阐发《黄帝内经》'),
('神农本草经集注', '陶弘景', '南北朝', '本草', '中国第一部本草学注释著作');

-- 经典条文
INSERT OR IGNORE INTO classic_text (book_id, chapter, section, content, translation, interpretation, tags) VALUES
(1, '太阳病上篇', '第1条', '太阳之为病，脉浮，头项强痛而恶寒。', '太阳病的主要表现是脉浮，头痛项强，并且怕冷。', '太阳病提纲，指出太阳病的主症和主脉。', '太阳病,脉浮,恶寒'),
(1, '太阳病上篇', '第11条', '病有发热恶寒者，发于阳也；无热恶寒者，发于阴也。', '生病时如果有发热又怕冷的，是阳证；如果只有怕冷而没有发热的，是阴证。', '阴阳辨证的重要依据。', '发热,恶寒,阴阳辨证'),
(1, '太阳病上篇', '第35条', '太阳病，头痛发热，身疼腰痛，骨节疼痛，恶风，无汗而喘者，麻黄汤主之。', '太阳病，头痛发热，身体疼痛，腰痛，骨节疼痛，怕风，无汗而喘的，用麻黄汤主治。', '麻黄汤证的主症。', '太阳病,麻黄汤,无汗而喘'),
(1, '太阳病上篇', '第96条', '伤寒五六日中风，往来寒热，胸胁苦满，嘿嘿不欲饮食，心烦喜呕，或胸中烦而不呕，或渴，或腹中痛，或胁下痞硬，或心下悸、小便不利，或不渴、身有微热，或咳者，小柴胡汤主之。', '伤寒五六日，中风，往来寒热，胸胁苦满，默默不欲饮食，心烦喜呕，或胸中烦而不呕，或口渴，或腹中痛，或胁下痞硬，或心下悸、小便不利，或不渴、身有微热，或咳嗽的，用小柴胡汤主治。', '小柴胡汤证的主症。', '少阳病,小柴胡汤,往来寒热'),
(1, '太阳病下篇', '第219条', '三阳合病，腹满身重，难以转侧，口不仁面垢，谵语遗尿。发汗则谵语，下之则额上生汗，手足逆冷。若自汗出者，白虎汤主之。', '三阳合病，腹部胀满身体沉重，难以转侧，口不仁面垢，谵语遗尿。发汗则谵语加重，攻下则额上出汗，手足逆冷。如果自汗出的，用白虎汤主治。', '白虎汤证的主症。', '三阳合病,白虎汤,自汗出'),
(2, '脏腑经络先后病脉证第一', '第1条', '问曰：上工治未病，何也？师曰：夫治未病者，见肝之病，知肝传脾，当先实脾，四季脾王不受邪，即勿补之。中工不晓相传，见肝之病，不解实脾，惟治肝也。', '问：上等的医生治疗未病，是什么意思？老师说：治疗未病，就是看到肝脏有病，知道肝脏会传变到脾脏，应当先充实脾脏，四季脾脏旺盛的时候不会受邪，就不用补它。中等的医生不懂得传变，看到肝脏有病，不知道充实脾脏，只治疗肝脏。', '治未病的思想。', '治未病,肝脾传变'),
(3, '素问·上古天真论', '第1条', '上古之人，其知道者，法于阴阳，和于术数，食饮有节，起居有常，不妄作劳，故能形与神俱，而尽终其天年，度百岁乃去。', '上古时代的人，那些懂得养生之道的，效法阴阳，调和术数，饮食有节制，起居有规律，不妄加劳作，所以能形神俱备，而终其天年，度过百岁才离去。', '养生的基本方法。', '养生,阴阳,术数'),
(4, '温病条辨·上焦篇', '第1条', '温病者，有风温、有温热、有温疫、有温毒、有暑温、有湿温、有秋燥、有冬温、有温疟。', '温病包括风温、温热、温疫、温毒、暑温、湿温、秋燥、冬温、温疟。', '温病的分类。', '温病,分类'),
(5, '神农本草经·上品', '第1条', '丹砂，味甘微寒。主身体五脏百病，养精神，安魂魄，益气，明目，杀精魅邪恶鬼。久服通神明不老。能化为汞。生山谷。', '丹砂，味甘微寒。主治身体五脏百病，滋养精神，安定魂魄，益气，明目，杀精魅邪恶鬼。长期服用通神明不老。能化为汞。生长在山谷中。', '丹砂的功效。', '丹砂,神农本草经');

-- 中药
INSERT OR IGNORE INTO chinese_medicine (name, pinyin, Latin, property, channel, function, indication, usage, caution, image_url) VALUES
('桂枝', 'guizhi', 'Ramulus Cinnamomi', '辛、甘，温', '心、肺、膀胱经', '发汗解肌，温通经脉，助阳化气', '风寒感冒，脘腹冷痛，血寒经闭，关节痹痛，痰饮，水肿', '煎服，3-10g', '温热病及阴虚阳盛之证、血证、孕妇忌用', 'guizhi.jpg'),
('芍药', 'shaoyao', 'Radix Paeoniae Alba', '苦、酸，微寒', '肝、脾经', '养血调经，敛阴止汗，柔肝止痛，平抑肝阳', '血虚萎黄，月经不调，自汗，盗汗，胁痛，腹痛，四肢挛痛，头痛眩晕', '煎服，6-15g', '不宜与藜芦同用', 'shaoyao.jpg'),
('麻黄', 'mahuang', 'Herba Ephedrae', '辛、微苦，温', '肺、膀胱经', '发汗解表，宣肺平喘，利水消肿', '风寒感冒，胸闷喘咳，风水浮肿', '煎服，2-10g', '表虚自汗、阴虚盗汗及肺肾虚喘者慎用', 'mahuang.jpg'),
('甘草', 'gancao', 'Radix Glycyrrhizae', '甘，平', '心、肺、脾、胃经', '补脾益气，清热解毒，祛痰止咳，缓急止痛，调和诸药', '脾胃虚弱，倦怠乏力，心悸气短，咳嗽痰多，脘腹、四肢挛急疼痛，痈肿疮毒', '煎服，2-10g', '不宜与海藻、京大戟、红大戟、甘遂、芫花同用', 'gancao.jpg'),
('生姜', 'shengjiang', 'Rhizoma Zingiberis Recens', '辛，温', '肺、脾、胃经', '解表散寒，温中止呕，化痰止咳，解鱼蟹毒', '风寒感冒，胃寒呕吐，寒痰咳嗽', '煎服，3-10g', '热盛及阴虚内热者忌服', 'shengjiang.jpg'),
('大枣', 'dazao', 'Fructus Jujubae', '甘，温', '脾、胃经', '补中益气，养血安神', '脾虚食少，乏力便溏，妇人脏躁', '煎服，6-15g', '湿盛脘腹胀满、食积、虫积、龋齿作痛及痰热咳嗽宜慎用', 'dazao.jpg'),
('杏仁', 'xingren', 'Semen Armeniacae Amarum', '苦，微温；有小毒', '肺、大肠经', '降气止咳平喘，润肠通便', '咳嗽气喘，胸满痰多，肠燥便秘', '煎服，3-10g', '阴虚咳喘及大便溏泄者忌用，婴儿慎用', 'xingren.jpg'),
('柴胡', 'chaihu', 'Radix Bupleuri', '苦、辛，微寒', '肝、胆经', '和解表里，疏肝解郁，升阳举陷', '感冒发热，寒热往来，胸胁胀痛，月经不调', '煎服，3-10g', '阴虚阳亢，肝风内动，阴虚火旺及气机上逆者忌用或慎用', 'chaihu.jpg'),
('黄芩', 'huangqin', 'Radix Scutellariae', '苦，寒', '肺、胆、脾、大肠、小肠经', '清热燥湿，泻火解毒，止血，安胎', '湿温、暑湿，胸闷呕恶，湿热痞满，泻痢，黄疸', '煎服，3-10g', '脾胃虚寒者不宜使用', 'huangqin.jpg'),
('半夏', 'banxia', 'Rhizoma Pinelliae', '辛，温；有毒', '脾、胃、肺经', '燥湿化痰，降逆止呕，消痞散结', '湿痰寒痰，咳喘痰多，痰饮眩悸，风痰眩晕', '煎服，3-9g', '不宜与川乌、制川乌、草乌、制草乌、附子同用', 'banxia.jpg');

-- 方剂
INSERT OR IGNORE INTO prescription (name, pinyin, source, category, composition, dosage, function, indication, explanation, syndromes) VALUES
('桂枝汤', 'guizhitang', '《伤寒论》', '解表剂', '桂枝、芍药、甘草、生姜、大枣', '桂枝9g，芍药9g，炙甘草6g，生姜9g，大枣3枚', '解肌发表，调和营卫', '外感风寒表虚证。头痛发热，汗出恶风，鼻鸣干呕，苔白不渴，脉浮缓或浮弱。', '桂枝为君，发汗解肌，温通经脉；芍药为臣，敛阴和营，与桂枝相配，调和营卫；炙甘草为佐使，调和诸药。', '头痛发热，汗出恶风，脉浮缓'),
('麻黄汤', 'mahuangtang', '《伤寒论》', '解表剂', '麻黄、桂枝、杏仁、炙甘草', '麻黄9g，桂枝6g，杏仁9g，炙甘草3g', '发汗解表，宣肺平喘', '外感风寒表实证。恶寒发热，头身疼痛，无汗而喘，舌苔薄白，脉浮紧。', '麻黄为君，发汗解表，宣肺平喘；桂枝为臣，助麻黄发汗解表；杏仁为佐，降利肺气以助平喘；炙甘草为使，调和诸药。', '恶寒发热，无汗而喘，脉浮紧'),
('小柴胡汤', 'xiaochaihutang', '《伤寒论》', '和解剂', '柴胡、黄芩、人参、半夏、甘草、生姜、大枣', '柴胡12g，黄芩9g，人参6g，半夏9g，炙甘草6g，生姜9g，大枣4枚', '和解少阳', '伤寒少阳证。往来寒热，胸胁苦满，嘿嘿不欲饮食，心烦喜呕，口苦，咽干，目眩，舌苔薄白，脉弦者。', '柴胡为君，透泄少阳之邪，并能疏泄气机之郁滞；黄芩为臣，清泄少阳之热；人参、半夏、炙甘草为佐，益气和胃，降逆止呕；生姜、大枣为使，调和营卫。', '往来寒热，胸胁苦满，脉弦'),
('白虎汤', 'baihutang', '《伤寒论》', '清热剂', '石膏、知母、甘草、粳米', '石膏30g，知母9g，炙甘草3g，粳米9g', '清热生津', '阳明气分热盛证。壮热面赤，烦渴引饮，汗出恶热，脉洪大有力。', '石膏为君，清热泻火，除烦止渴；知母为臣，清热养阴，润燥生津；炙甘草、粳米为佐使，益胃生津，调和诸药。', '壮热面赤，烦渴引饮，脉洪大'),
('四君子汤', 'sijunzitang', '《太平惠民和剂局方》', '补气剂', '人参、白术、茯苓、甘草', '人参9g，白术9g，茯苓9g，炙甘草6g', '益气健脾', '脾胃气虚证。面色萎白，语声低微，气短乏力，食少便溏，舌淡苔白，脉虚弱。', '人参为君，益气健脾；白术为臣，健脾燥湿；茯苓为佐，健脾渗湿；炙甘草为使，调和诸药。', '面色萎白，食少便溏，脉虚弱'),
('四物汤', 'siwutang', '《仙授理伤续断秘方》', '补血剂', '当归、川芎、白芍、熟地', '当归9g，川芎6g，白芍9g，熟地12g', '补血调血', '营血虚滞证。头晕目眩，心悸失眠，面色无华，妇人月经不调，量少或经闭不行，脐腹作痛，甚或瘕块硬结，舌淡，口唇、爪甲色淡，脉细弦或细涩。', '熟地为君，滋阴补血；当归为臣，补血活血；白芍为佐，养血敛阴；川芎为使，活血行气；四药合用，补血调血。', '头晕目眩，月经不调，脉细弦'),
('六味地黄丸', 'liuwei dihuangwan', '《小儿药证直诀》', '补阴剂', '熟地、山萸肉、山药、泽泻、牡丹皮、茯苓', '熟地24g，山萸肉12g，山药12g，泽泻9g，牡丹皮9g，茯苓9g', '滋阴补肾', '肾阴亏损证。头晕耳鸣，腰膝酸软，骨蒸潮热，盗汗遗精，消渴。', '熟地为君，滋阴补肾，填精益髓；山萸肉、山药为臣，补肝脾而益精血；泽泻、牡丹皮、茯苓为佐，利湿泄浊，清泻相火，健脾渗湿；六药合用，滋阴补肾。', '头晕耳鸣，腰膝酸软，盗汗遗精');

-- 方剂组成
INSERT OR IGNORE INTO prescription_medicine (prescription_id, medicine_id, dosage, role) VALUES
(1, 1, '9g', '君'),
(1, 2, '9g', '臣'),
(1, 4, '6g', '佐使'),
(1, 5, '9g', '佐使'),
(1, 6, '3枚', '佐使'),
(2, 3, '9g', '君'),
(2, 1, '6g', '臣'),
(2, 7, '9g', '佐'),
(2, 4, '3g', '使'),
(3, 8, '12g', '君'),
(3, 9, '9g', '臣'),
(3, 4, '6g', '佐使');

-- 脉诊
INSERT OR IGNORE INTO pulse_diagnosis (name, pinyin, description, mechanism, image_url, syndromes, prescriptions) VALUES
('浮脉', 'fumai', '轻取即得，重按稍减而不空，举之有余，按之不足。', '表证，亦主虚证', 'fumai.jpg', '表证', '桂枝汤,麻黄汤'),
('弦脉', 'xianmai', '端直以长，如按琴弦。', '肝胆病，痰饮，疼痛，疟疾', 'xianmai.jpg', '肝胆病,疼痛', '小柴胡汤,逍遥散'),
('细脉', 'ximai', '脉细如线，但应指明显。', '气血两虚，湿邪', 'ximai.jpg', '气血两虚,湿邪', '四君子汤,四物汤'),
('沉脉', 'chenmai', '轻取不应，重按始得。', '里证', 'chenmai.jpg', '里证', '真武汤,麻黄细辛附子汤'),
('滑脉', 'huamai', '往来流利，应指圆滑，如盘走珠。', '痰湿，食积，实热', 'huamai.jpg', '痰湿,食积', '二陈汤,保和丸'),
('涩脉', 'shemai', '往来艰涩不畅，如轻刀刮竹。', '气滞，血瘀，精伤，血少', 'shemai.jpg', '气滞,血瘀', '血府逐瘀汤,逍遥丸'),
('数脉', 'shumai', '脉来急促，一息五至以上而不满七至。', '热证', 'shumai.jpg', '热证', '白虎汤,黄连解毒汤'),
('迟脉', 'chimai', '脉来迟缓，一息不足四至。', '寒证', 'chimai.jpg', '寒证', '理中丸,四逆汤'),
('洪脉', 'hongmai', '脉体宽大，充实有力，来盛去衰，状若波涛汹涌。', '热盛', 'hongmai.jpg', '热盛', '白虎汤,黄连解毒汤'),
('紧脉', 'jinmai', '脉来绷急，状若牵绳转索。', '寒证，痛证，宿食', 'jinmai.jpg', '寒证,痛证', '麻黄汤,理中丸'),
('缓脉', 'huanmai', '一息四至，来去怠缓。', '湿证，脾胃虚弱', 'huanmai.jpg', '湿证,脾胃虚弱', '平胃散,四君子汤'),
('濡脉', 'rumai', '浮细无力而软。', '虚证，湿证', 'rumai.jpg', '虚证,湿证', '四君子汤,平胃散'),
('弱脉', 'ruomai', '沉细无力而软。', '气血两虚', 'ruomai.jpg', '气血两虚', '八珍汤,十全大补汤'),
('虚脉', 'xumai', '三部脉举之无力，按之空豁，应指松软。', '虚证', 'xumai.jpg', '虚证', '四君子汤,四物汤'),
('实脉', 'shimai', '三部脉举按均有力。', '实证', 'shimai.jpg', '实证', '大承气汤,小承气汤');

-- 舌诊
INSERT OR IGNORE INTO tongue_diagnosis (tongue_coating, tongue_body, description, mechanism, image_url, syndromes, prescriptions) VALUES
('薄白苔', '淡红舌', '舌质淡红，舌苔薄白。', '正常舌象，或表证初起', 'dan hong she.jpg', '正常,表证初起', '桂枝汤,麻黄汤'),
('薄黄苔', '红舌', '舌质红，舌苔薄黄。', '热证初起，表热证', 'hong she.jpg', '热证初起,表热证', '银翘散,桑菊饮'),
('黄厚苔', '红舌', '舌质红，舌苔黄厚。', '里热证，食积', 'huang hou tai.jpg', '里热证,食积', '白虎汤,保和丸'),
('白腻苔', '淡红舌', '舌质淡红，舌苔白腻。', '痰湿证，寒湿证', 'bai ni tai.jpg', '痰湿证,寒湿证', '二陈汤,平胃散'),
('黄腻苔', '红舌', '舌质红，舌苔黄腻。', '湿热证', 'huang ni tai.jpg', '湿热证', '三仁汤,茵陈蒿汤'),
('少苔', '红舌', '舌质红，舌苔少。', '阴虚证', 'shao tai.jpg', '阴虚证', '六味地黄丸,知柏地黄丸'),
('无苔', '红绛舌', '舌质红绛，无舌苔。', '阴虚火旺证', 'wu tai.jpg', '阴虚火旺证', '大补阴丸,知柏地黄丸'),
('灰黑苔', '淡白舌', '舌质淡白，舌苔灰黑。', '阳虚寒盛证', 'hui hei tai.jpg', '阳虚寒盛证', '四逆汤,真武汤'),
('裂纹舌', '红舌', '舌质红，舌面有裂纹。', '阴虚证，热盛伤津', 'lie wen she.jpg', '阴虚证,热盛伤津', '六味地黄丸,白虎汤'),
('齿痕舌', '淡白舌', '舌质淡白，舌边有齿痕。', '脾虚湿盛证', 'chi hen she.jpg', '脾虚湿盛证', '参苓白术散,四君子汤'),
('胖大舌', '淡白舌', '舌质淡白，舌体胖大。', '阳虚水湿内停', 'pang da she.jpg', '阳虚水湿内停', '真武汤,五苓散'),
('瘦薄舌', '红舌', '舌质红，舌体瘦薄。', '阴虚火旺', 'shou bo she.jpg', '阴虚火旺', '六味地黄丸,知柏地黄丸'),
('红绛舌', '红绛舌', '舌质红绛，舌面光滑。', '热入营血', 'hong jiang she.jpg', '热入营血', '清营汤,犀角地黄汤');

-- 类方关系表测试数据
INSERT OR IGNORE INTO prescription_relation (prescription_id, related_id, relation_type) VALUES
(1, 2, '类方'),
(1, 3, '衍生方'),
(2, 1, '类方'),
(3, 1, '衍生方'),
(3, 4, '类方'),
(4, 3, '类方'),
(5, 6, '类方'),
(6, 5, '类方'),
(6, 7, '衍生方'),
(7, 6, '衍生方');

-- 中药药证表测试数据
INSERT OR IGNORE INTO medicine_syndrome (medicine_id, syndrome) VALUES
(1, '桂枝证：气上冲，自汗出'),
(2, '芍药证：腹痛，拘急'),
(3, '麻黄证：无汗而喘，身疼痛'),
(4, '甘草证：咽痛，挛急'),
(5, '生姜证：呕吐，呕逆'),
(6, '大枣证：虚劳，失眠'),
(7, '杏仁证：咳喘，便秘'),
(8, '柴胡证：往来寒热，胸胁苦满'),
(9, '黄芩证：烦热，口苦'),
(10, '半夏证：呕吐，痰饮'),
(1, '太阳中风，脉浮缓'),
(2, '太阳病，腹痛'),
(3, '太阳伤寒，脉浮紧'),
(4, '脾胃虚弱，倦怠乏力'),
(5, '胃寒呕吐'),
(6, '妇人脏躁'),
(7, '肠燥便秘'),
(8, '少阳病，口苦咽干'),
(9, '热证，心烦');