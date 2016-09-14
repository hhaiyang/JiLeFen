<?php
header('Access-Control-Allow-Origin:*');
header('content-type:application:json;charset=utf8');
header('Access-Control-Allow-Methods:POST');
header('Access-Control-Allow-Headers:x-requested-with,content-type');
session_start();
error_reporting(E_ALL^E_NOTICE);
__FILE__ == '' && die('Fatal error code: 0');
if (isset($_REQUEST['GLOBALS']) OR isset($_FILES['GLOBALS'])) {
	exit('Request tainting attempted.');
}
@set_magic_quotes_runtime(0);
if (defined('DEBUG_MODE') == false) define('DEBUG_MODE', 0);
if(PHP_VERSION < '4.1.0') {
	$_GET =	&$HTTP_GET_VARS;
	$_SERVER = &$HTTP_SERVER_VARS;
	unset($HTTP_GET_VARS,$HTTP_SERVER_VARS);
}
if(function_exists('date_default_timezone_set')) date_default_timezone_set('Hongkong');

define('IN_MYMPS',true);
define('WAP',true);
define('WAPDIR',dirname(__FILE__));
define('MYMPS_ROOT' , WAPDIR.'/..');
define('MYMPS_INC'	, MYMPS_ROOT.'/include');
define('MYMPS_DATA'	, MYMPS_ROOT.'/data');
define('MYMPS_SMARTY', MYMPS_ROOT.'/include/smarty');
define('MYMPS_ASS', MYMPS_ROOT.'/include/assign');

session_save_path(MYMPS_DATA.'/sessions');
require_once MYMPS_ASS."/page.class.php";
require_once MYMPS_DATA.'/config.php';
require_once MYMPS_DATA.'/config.db.php';
require_once MYMPS_INC."/db.class.php";
include MYMPS_INC.'/common.fun.php';
include MYMPS_INC.'/cache.fun.php';
include MYMPS_INC.'/class.fun.php';
include MYMPS_ROOT.'/version.php';
include WAPDIR.'/include/inc_index.php';

//$conn = mysql_connect("localhost","root","");//这是我的数据库地址、用户名、密码
$conn = mysql_connect("localhost","net29172485","Y0X5PMgR");//这是我的数据库地址、用户名、密码//
mysql_select_db("net29172485");//这是我的数据库名
mysql_query("set names 'gbk'");

/****************************************************************************************************/
/***************    json数据格式输出二维数组              json_echo($arrlist);			*************/
/***************    json数据格式输出一维数组              json_print($arrlist)			*************/
/****************************************************************************************************/
//echo "<pre>";
/**
*	powered by詹英2015年9月
*	APP首页数据	$arrlist
*/

header("Content-Type: text/html; charset=utf-8");	
{	
	$url="http://www.ugohb.com";
	if($_GET['app']=='index_list'){
		$arrlist=app_indexList();
		json_echo($arrlist);
		//echo json_encode($arrlist);
		//print_r($arrlist);
	}elseif($_GET['app']=='app_list'){
		$arrlist=app_index();
		//print_r($arrlist);
		//echo '{"img0":"'.$url.$arrlist[0][img_path].'"}';
		echo "[";
		for($i=0;$i<4;$i++){
			echo '{';
				echo '"img":"'.$url.$arrlist[$i][img_path].'",';	
				echo '"url":"'.$arrlist[$i][url].'"';				
			echo '}';
			if($i!=3){echo ",";}
		}
		echo "]";
		//print_r($arrlist);
		
		
	}elseif($_GET['app']=='app_flash'){
		
		
	}	
}
function showflash(){
	$arrlist=app_indexFlash();
	//print_r($arrlist);
	$j=0;
	echo "[";
		for($i=0;$i<count($arrlist);$i++){
			$j++;
			echo '{"url":"'.$arrlist[$i][f_url].'",';
			echo '"imgurl":"'.$url.$arrlist[$i][f_img].'"}';
			if($j!=count($arrlist)){
				echo ",";
			}
		}
	echo "]";
}
function appList(){
	$arrlist=app_index();
		//print_r($arrlist);
		//echo '{"img0":"'.$url.$arrlist[0][img_path].'"}';
		echo "[";
		for($i=0;$i<4;$i++){
			echo '{';
				echo '"img":"'.$url.$arrlist[$i][img_path].'",';	
				echo '"url":"'.$arrlist[$i][url].'"';				
			echo '}';
			if($i!=3){echo ",";}
		}
		echo "]";
}
if($_GET['app']=='index'){
	$url="http://www.ugohb.com";
	$arrlist=app_indexList();
	echo '{"list":';
		json_echo($arrlist);
	echo ',"flash":';
	showflash();
	
	echo ',"appList":';
	appList();
	echo '}';
	
}

/**
*	powered by詹英2015年9月
*	APP分类页数据	$cat_list
*/
{	
	if($_GET['categorys']=='index'){
		include WAPDIR.'/include/inc_catelist.php';		
		//print_r($cat_list);
		
		
			$i=0;	
	echo '[';
	foreach($cat_list as $k=>$v){
		$i++;
		echo '{';
		$j=0;
		foreach($v as $key=>$val){
			$j++;
			$jk=0;
			foreach($val as $mk=>$mv){
				$jk++;
				echo '"'.$mk.'":"'.characet($mv).'"'; 
				if($jk!=count($val)){echo ',';}
			}
			
			if($j!=count($v)){
				echo ', ';
			}
			
		}
		echo '}';
		if($i!=count($cat_list)){
			echo ', ';
		}			
	}
echo ']';
		
	}
}

/**
*	powered by詹英2015年9月
*	APP列表页数据	$arr_list列表数据   $cat_list分类数据
*	传入id列表页
*/
{	
	if($_GET['categorys']=='list'&&$_GET['id']!=''){
		include WAPDIR.'/catelist.php';		
		json_echo($arr_list);
	}elseif($_GET['categorys']=='list'&&$_GET['did']!=''){
		include WAPDIR.'/diszhe.php';		
		json_echo($arr_list);
	}
}


/**
*	powered by詹英2015年9月
*	APP会员登录页数据	
*	传入dologin=1;如果为0为显示登录界面post方式提交
*	用户名 = $_POST['name'];
*	密码= $_POST['pwd'];
* 	返回值：userid 和$user_msg
*	验证码获取路径：../randcode.php id="chkimg"
*/
{	
	if($_GET['login']=='user'){
		include WAPDIR.'/login.php';
		echo $user_msg;
	}
}
/**
*	powered by詹英2015年9月
*	APP会员注册页数据	
*	传入dologin=1;如果为0为显示登录界面post方式提交
*	暂无注册
*/
{	
//	if($_GET['reg']=='user'){
//		include WAPDIR.'/register.php';	
//	}
}

/**
*	powered by詹英2015年9月
*	APP详情页数据	
*	传入id 不能为空	
* 	返回 数组	$res_ls
*	内容详情 	$content	活动状态 	$zhutai
*	店铺信息 	$res_s 		店铺其他信息 $arr_xs(有bug)
*	此店铺所发团购信息 		$arr_gs(有bug)
*	例：app.php?detlist=index&id=3055
*
*/
{	
	if($_GET['detlist']=='index'&&$_GET['id']!=''){
		include WAPDIR.'/detlist.php';	
		//json_print($res_ls);
		
		$result['id']=$res_ls['id'];
		$result['title']=$res_ls['title'];
		$result['img']=$res_ls['img_path'];
		$result['time']=$stime;
		$result['zhutai']=$zhutai;
		$result['shang_id']=$res_s['id'];
		$result['shang_name']=$res_s['tname'];
		$result['shang_tel']=$res_s['tel'];
		$result['shang_address']=$res_s['address'];
		
		json_print($result);
	}
	
	if($_GET['detailshop']=='index'&&$_GET['id']!=''){
		include WAPDIR.'/detailshop.php';	
		//print_r($res_s);
		$res['id']=$res_s['id'];
		$res['tname']=$res_s['tname'];
		$res['tel']=$res_s['tel'];
		$res['address']=$res_s['address'];		
		$res['jianjie']=$res_s['jianjie'];			
		$res['logo']=$res_s['logo'];
		
		//print_r($res_s);
		//print_r($arr_xs);
		$ak=0;
		$res_list=array();
		if($arr_xs){
			foreach($arr_xs as $k=>$v){
				$res_list[$ak]['id']=$v['id'];
				$res_list[$ak]['title']=$v['title'];			
				$res_list[$ak]['is_tuan']=$v['is_tuan'];
				$res_list[$ak]['is_zhe']=$v['is_zhe'];
				$res_list[$ak]['is_man']=$v['is_man'];
				$res_list[$ak]['is_zeng']=$v['is_zeng'];			
				$ak++;
			}
		}
		
		echo '{"shang":';
		json_print($res);
		echo ',"list":';
		json_echo($res_list);
		echo '}';
		
	}
}

/**
*	|-会员中心		----->app.php?u=index
*		|-我的预定
*		|-我的关注
*		|-我的消息
*	|-会员信息
*		|-我的资料
*		|-我的密码
*
*/
if($_GET['u']=='index'){
	
}
/**
*	|--会员积分页===>命名app.php?j=index            type
*		|--	积分商品兑换列表····jgoodsList	=>	jgoods			//eg:http://www.ugohb.com/app/app.php?j=index&type=jgoods
*		|-- 会员积分获取······jget			=>	result
*		|-- 会员积分详情······jdetails		=>	$jdet_arr
*		|-- 会员积分记录······jrecord		=>	$jre_arr
*	|-
*			-----require------
*		$count		=	$_POST['count'];
*		$passCode	=	$_POST['passCode'];
*		$myId	 	=	$_POST['myId'];
*
*/
if($_GET['j']=='user'){
	include WAPDIR.'/include/inc_user.php';
	$type = $_GET['type'];
    header("Content-Type: text/html; charset=gbk");	
    switch($type){
		case forgetpwd:
		echo json_encode($result);
		break;
		case firstcategory: //一级分类
			$result=$db->getall("select catid,catname,icon from {$db_mymps}category where parentid = 0 and modid = 1");
			if($result){
				foreach ($result as $key=>&$val){
					$val['catname'] = iconv('gbk','utf-8',$val['catname']);
				}
			}
			echo json_encode($result);
			break;
		case childcategory: //二级分类
			$parentid = $_POST['parentid'];
			$result=$db->getall("select catid,catname,icon from {$db_mymps}category where parentid = '".$parentid."'");
			if($result){
				foreach ($result as $key=>&$val){
					$val['catname'] = iconv('gbk','utf-8',$val['catname']);
				}
			}
			echo json_encode($result);
			break;
		case goodseacher://商品查询
			$code = $_POST['code'];
    		$where = '';
			if($code){
				$where = $where." or name LIKE '%".$code."%' or prices LIKE '%".$code."%'";
			}
			$result=$db->getAll("select id,name,mun,prices,detail,img_path,myCode from {$db_mymps}jifen_goods where 1=1 ".$where);
			if($result){
				echo json_encode($result);
			}else {
				$result['status'] =0;
				echo json_encode($result);
			}
			break;
		case addcomment://添加评论
			$content = $_POST['content']; //内容
			$typeid = $_POST['typeid'];//类型Id 商品，用户Id
			$level = isset($_POST['level'])?$_POST['level']:2; //评论级别 如好评，差评，中评
			$ip = getenv('REMOTE_ADDR');
    		if (($ip_ != "") && ($ip_ != "unknown")){
				$ip=$ip_;
			}
			$time = time();
			$userid = $_POST['userid']; //用户Id
			$type = 'information';
			if($content!=''&&$typeid!=''&&$userid!=''){
				//echo "INSERT INTO `{$db_mymps}comment` (userid,content,pubtime,ip,comment_level,typeid,type) VALUES('".$userid."','".$content."','".$time."','".$ip."','".$level."','".$typeid."','".$type."')";
				$db->query("INSERT INTO `{$db_mymps}comment` (userid,content,pubtime,ip,comment_level,typeid,type) VALUES ('".$userid."','".$content."',".$time.",'".$ip."',".$level.",".$typeid.",'".$type."')");
				$data['status'] = 1;
			}else{
				$data['status'] = 0;
			}
			echo json_encode($data);
			break;
		case getcomment: //获取评论
			$id = $_POST['id'];
			$result=$db->getAll("select id,userid,content,pubtime,comment_level,typeid,type from {$db_mymps}comment where id = '".$id."'");
			if($result){
				$data['result'] = $result;
				$data['msg'] = 1;
			}else{
				$data['msg'] = 0;
			}
			echo json_encode($data);
			break;  
		case getagentinfo: //获取商家信息
			$userid = $_POST['userid'];
			//echo "UPDATE {$db_mymps}comment SET content='3453453' where id=2";
			$result=$db->getAll("select * from {$db_mymps}member where userid = '".$userid."'");
			if($result){
				foreach ($result as $key=>&$val){
					$val['cname'] = iconv('gbk','utf-8',$val['cname']);
					$val['tname'] = iconv('gbk','utf-8',$val['tname']);
					$val['carbradname'] = iconv('gbk','utf-8',$val['carbradname']);
					$val['sex'] = iconv('gbk','utf-8',$val['sex']);
					$val['address'] = iconv('gbk','utf-8',$val['address']);
					$val['shuoming'] = iconv('gbk','utf-8',$val['shuoming']);
					$val['jianjie'] = iconv('gbk','utf-8',$val['jianjie']);
				}
				$data['result'] = $result;
				$data['msg'] = 1;
			}else{
				$data['msg'] = 0;
			}
			echo json_encode($data);
			break;
		case getad: //获取广告
			$type = $_POST['type'];
			$result=$db->getAll("select advid,type,displayorder,title,code,starttime,endtime from {$db_mymps}advertisement where available = 1 and type = '".$type."'");
			if($result){
				foreach ($result as $key=>&$val){
					$val['title'] = iconv('gbk','utf-8',$val['title']);
				}
			}
			echo json_encode($result);
			break;
		case upflog: //开启兑换功能
			$id = $_POST['userid'];
			if($id){
				$db->query("UPDATE {$db_mymps}member SET flog=1 where userid='".$id."'");
				$result['status'] = 1;
			}else{
				$result['status'] = 0;
			}
			echo json_encode($result);
			break;
		case searchcode: //热词搜索
			$code = $_POST['code'];
			$arr = array();
			$catid_arr=$db->getAll("select catid from {$db_mymps}category where catname LIKE '%".$code."%'");
			$areaid_arr=$db->getAll("select areaid from {$db_mymps}area where areaname LIKE '%".$code."%'");
			if($catid_arr){
				$str_catid = '';
				foreach ($catid_arr as $key=>$val){
					if($str_catid==''){
						$str_catid = $val['catid'];
					}else{
						$str_catid = $str_catid.','.$val['catid'];
					}
				}
				unset($catid_arr);
			}
    		if($areaid_arr){
				$str_areaid = '';
				foreach ($areaid_arr as $keys=>$vals){
					if($str_areaid==''){
						$str_areaid = $vals['areaid'];
					}else{
						$str_areaid = $str_areaid.','.$vals['areaid'];
					}
				}
				//unset($areaid_arr);
			}
			$where = '';
			if($str_catid){
				$where = $where." or catid in('$str_catid')";
			}
			if($str_areaid){
				$where = $where." or areaid in('$str_areaid')";
			}
			//echo "select catname,userid from {$db_mymps}information where title LIKE '%".$code."%' ".$where;
			$result=$db->getAll("select id,title,begintime,endtime,userid,tel,zhekoufd,yuanjia,xianjia,img_path from {$db_mymps}information where title LIKE '%".$code."%' ".$where);
			if($result){
				foreach ($result as $key=>&$val){
					$val['title'] = iconv('gbk','utf-8',$val['title']);
				}
			}
			echo json_encode($result);
		break;
    }
}
if($_GET['j']=='index'){
	include WAPDIR.'/include/inc_user.php';
	$type = $_GET['type'];
    header("Content-Type: text/html; charset=gbk");	
	switch($type){
		case userinfo: //用户的积分情况和兑换情况
		$userid=$_POST['userid'];
		$result=$db->get_one("select v_mun,userid from {$db_mymps}jifen_mun where userid ='".$userid."'");
		$count=$db->getall("select count(*) as tongji from {$db_mymps}jifen_record where userid='".$userid."' and type=0 group by isget");
		$hasget =$count[1]['tongji']?$count[1]['tongji']:0;
		$notget =$count[0]['tongji']?$count[0]['tongji']:0;
		if($result){
		$result['status'] = 1;
        $result['hasget']=$hasget;
        $result['notget']=$notget;  		
		}else{
		$result['status'] =0;	
		}
		echo json_encode($result);
		break;
		
		case appinfo:
		$id=$_POST['id'];
		$data=$db->get_one("select id,content from {$db_mymps}announce where id ='".$id."'");
		$result['status'] = $data['id']?1:0;
		$result['info'] =urlencode($data['content']);
		echo urldecode(json_encode($result));
		break;
		
		case addjifen: //添加积分
		$jifen_mun =$_POST['jifen_num'];
		$myCode =$_POST['mycode'];
		$userid =$_POST['userid'];
		$time=time();
		$data['userid'] =$userid;
	    if($myCode==''&&$jifen_mun==''){
			$data['status'] =-1;
			echo json_encode($data);
		}else{
			$where="where userid ='".$userid."'";
			$count=mymps_count('jifen_mun',$where);
			$bcount=$db->getAll("select v_mun,userid from {$db_mymps}jifen_mun where myCode ='".$myCode."'" );
		//	print_r("select v_mun,userid from {$db_mymps}jifen_mun where myCode ='".$myCode."'");
			if($bcount){
			 if($bcount[0]['v_mun']-$jifen_mun<0){
				 $data['status'] = -2;
			 }else{
			 $db->query("UPDATE {$db_mymps}jifen_mun SET v_mun=v_mun-'".$jifen_mun."' where myCode='".$myCode."'");
			if($count){		
			 $db->query("UPDATE {$db_mymps}jifen_mun SET v_mun=v_mun+'".$jifen_mun."',jifen_mun = jifen_mun+'".$jifen_mun."' where userid='".$userid."'");
			 }else{	
            // print_r($userid);		echo "<br>";	 
			 $db->query("INSERT INTO `{$db_mymps}jifen_mun` (userid,type,v_mun,jifen_mun,date) VALUES('".$userid."','1','".$jifen_mun."','".$jifen_mun."',".$time.")" );	 
			 }
			 $db->query("INSERT INTO `{$db_mymps}jifen_record` (userid,count,host,type,date) VALUES('".$userid."','".$jifen_mun."','".$bcount[0]['userid']."',1,'".$time."')" );	
             $data['status'] =1;
             }			 
			}else{
		     $data['status'] =0;	
			}
			echo json_encode($data);
		}
		break;
		case addactive:  //发布活动
			$userid =$_POST['userid'];
			$title = $_POST['title'];
			//$catid = isset($_POST['catid'])?$_POST['catid']:0; //二级
			//$catid_one = isset($_POST['catid_one'])?$_POST['catid_one']:0; //一级分类
			//$areaid = isset($_POST['areaid'])?$_POST['areaid']:0; //地域
			$begintime = $_POST['start'];
			$endtime = $_POST['end'];
			$img_path = $_POST['img_path'];
			$content = $_POST['content'];
			$ip=GetIP();
			//$yuanjia = isset($_POST['yuanjia'])?$_POST['yuanjia']:0;
			$mycode = "mycode".md5($userid);
			$activetime = time();
			if($userid!=''&&$title!=''&&$begintime!=''&&$endtime!=''&&$content!=''){
				//echo "INSERT INTO `{$db_mymps}information` (userid,title,img_path,begintime,endtime,activetime,content,ip) VALUES('".$userid."','".$title."','".$img_path."','".$begintime."','".$endtime."','".$activetime."','".$content."','".$ip."')" ;
				$db->query("INSERT INTO `{$db_mymps}information` (userid,title,img_path,begintime,endtime,activetime,content,ip) VALUES('".$userid."','".$title."','".$img_path."','".$begintime."','".$endtime."','".$activetime."','".$content."','".$ip."')" );
				$data['status'] = 1;
			}else{
				$data['status'] = 0;
			}
			echo json_encode($data);
		break;
		case getaddress: //获取地址
			$activelist=$db->getAll("select areaid,areaname,parentid from my_area ORDER BY areaorder");
			$result['data'] = $activelist;
//			if($activelist){
//				$result['status']=1;
//			}else{
//				$result['status']=0;
//			}
				foreach ($activelist as $key=>&$val){
					$val['areaname'] = iconv('gbk','utf-8',$val['areaname']);
				}
			echo json_encode($result);
		break;
		case activelist:  //活动列表
			$time = time();
			$activelist=$db->getAll("select title,content,img_path,begintime,endtime,hit from my_information where begintime<'".$time."' and endtime>'".$time."'");
		
			if($activelist){
				foreach ($activelist as $key=>&$val){
					$val['title'] = iconv('gbk','utf-8',$val['title']);
					$val['content'] = iconv('gbk','utf-8',$val['content']);
				}
				$result['data']=$activelist;
				$result['status']=1;
			}else{
				$result['status'] =0;	
			}
		
		    echo json_encode($result);
		break;
		case activeinfo:  //活动详情
			$id=$_POST['id'];
			$data =$db->get_one("select id,title,content,img_path,begintime,endtime,hit from {$db_mymps}information where id=".$id);
			if($data){
				$db->query("UPDATE {$db_mymps}information SET hit='".($data['hit']+1)."' where id='".$id."'");
				$result['data'] =$data;
	            $result['status'] =1;			
			}else{
				$result['status'] =0;		
			}
		    echo json_encode($result);
		break;
		case checkcodes:  //验证兑换码
			$id = $_POST['userid']; //商家id
			$code = $_POST['code']; //兑换码
			$sql = "select id,goods_id,name from {$db_mymps}jifen_record where userid=".$id." and orderCode='".$code."'";
			//echo $sql;
			$result['data']=$db -> get_one($sql);
			if($result['data']){
				foreach ($result['data'] as $key=>&$val){
					$val['name'] = iconv('gbk','utf-8',$val['name']);
				}
				$result['status'] = 1;
			}else{
				$result['status'] = 0;
			}
			echo json_encode($result);
		break;
		case getnum: //获取可用积分
			$userid = $_POST['userid']; //当前用户 
			//$userid ='18158912554';
			$sql = "select v_mun,type from {$db_mymps}jifen_mun where userid ='".$userid."'";
			$userinfo=$db->getall($sql);
			if($userinfo){
				$result['status'] = 1;
				$result['data'] = $userinfo;
			}else{
				$result['status'] = 0;
			}
			echo json_encode($result);
		break;
		case getuserlog: //消费者向商家索要记录
			$userid = $_POST['userid']; //当前用户
			$starttime = strtotime($_POST['starttime']);//开始时间
			$endtime = strtotime($_POST['endtime']);//结束时间
			$pagesize = $_POST['pagesize']; //分页预留
			$pagenum = $_POST['pagenum']; //分页预留
			$sql = "select userid,count,detail,date from {$db_mymps}jifen_record where userid ='".$userid."' and type =1 and host !='' and date > '".$starttime."' and date < '".$endtime."'";
			$userinfo=$db->getall($sql);
			if($userinfo){
				$result['status'] = 1;
				$result['data'] = $userinfo;
			}else{
				$result['status'] = 0;
			}
			echo json_encode($result);
		break;
		case getagentlog: //商家向平台索要记录
			$userid = $_SESSION['userid']; //当前用户
			$starttime = strtotime($_POST['starttime']);//开始时间
			$endtime = strtotime($_POST['endtime']);//结束时间
			$sql = "select userid,count,detail,date from {$db_mymps}jifen_record where userid ='".$userid."' and type =1 and host ='' and date > '".$starttime."' and date < '".$endtime."'";
			$userinfo=$db->getall($sql);
			if($userinfo){
				$result['status'] = 1;
				$result['data'] = $userinfo;
			}else{
				$result['status'] = 0;
			}
			echo json_encode($result);
		break;
		case updatepoints: //修改积分倍数
			$id = $_POST['id']; //商品Id
			$starttime  =  strtotime($_POST['starttime']);
			$endtime = strtotime($_POST['endtime']);
			$points = $_POST['points']; //积分倍数
			//$data =$db->get_one("select id from {$db_mymps}jifen_goods where id=".$id. " and starttime < '".time()."' and endtime>'".time()."'");
			$data =$db->get_one("select id from {$db_mymps}information where id=".$id. " and begintime < '".time()."' and endtime>'".time()."'");
			if($data){
            	$result['status'] =2; //积分在有效期内，不能修改		
            	$result['msg'] = '积分在有效期内，不能修改';	
			}else{
				if($endtime && $starttime){
					//$db->query("update {$db_mymps}jifen_goods set points = ".$points.", starttime='".$starttime."',endtime = '".$endtime."' where id=".$id);
					$db->query("update {$db_mymps}information set points = ".$points.", begintime='".$starttime."',endtime = '".$endtime."' where id=".$id);
					$result['status'] =1; //修改成功
				}else{
					$result['status'] = 0;
					$result['msg'] = '修改失败';
				}
			}
			echo json_encode($result);
		break;
		case jifenlist:  //积分明细
		$userid =$_POST['userid'];
		$pagesize = $_POST['pagesize'];
		$pagenum = $_POST['pagenum'];
		$pagesize = $pagesize<1?1:$pagesize;
		$fields=" a.id,a.type,a.userid,a.count,a.detail,a.`host` ,a.date,a.name,a.orderCode,b.tname";
		$join="{$db_mymps}jifen_record a join {$db_mymps}member b on a.host = b.userid";
		$sql ="SELECT ".$fields."  FROM ".$join." where a.userid='".$userid."' limit ".($pagesize-1)*$pagenum.",".$pagenum;
		$result['data']=$db -> getall($sql);
		if($result){
			foreach ($result as $key=>&$val){
				$val['tname'] = iconv('gbk','utf-8',$val['tname']);
			}
		$where ="where userid='".$userid."' limit ".($pagesize-1)*$pagenum.",".$pagenum;
		$count['sum'] =mymps_count('jifen_record',$where);
		$count['pagesize'] =$pagesize;
		$count['pagenum'] =$pagenum;
		$result['count'] =$count;
		$result['status'] =1;
		}else{
		$result['status'] =0;	
		}
		echo json_encode($result);
		break;
		case goodslist:
		$pagesize = $_POST['pagesize'];
		$pagenum = $_POST['pagenum'];
		$isget =$_POST['isget'];
		$pagesize = $pagesize<1?1:$pagesize;
		$sql ="SELECT * FROM {$db_mymps}jifen_goods limit ".($pagesize-1)*$pagenum.",".$pagenum;
		$result['data']=$db -> getall($sql);
		if($result){
        $count['sum'] =mymps_count('jifen_goods');
		$count['pagesize'] =$pagesize;
		$count['pagenum'] =$pagenum;
		$result['count'] = $count;
		$result['status'] =1;			
		}else{
		$result['status'] =0;	
		}
		echo json_encode($result);
		break;
		case goodsinfo: //活动详情
		$id=$_POST['id'];
		//$data =$db->get_one("select id,title,prices,num,points,img_path,mycode,begintime,endtime from {$db_mymps}information where id=".$id);
		$data =$db->get_one("select id,name,prices,detail,img_path,myCode from {$db_mymps}jifen_goods where id=".$id);
		if($data){
			foreach ($data as $key=>&$val){
				$val['title'] = iconv('gbk','utf-8',$val['name']);
			}
			$result['data'] =$data;
            $result['status'] =1;			
		}else{
			$result['status'] =0;		
		}
		echo json_encode($result);
		break;
		case getcodesgood: //根据验证码获取商品详情
			$code=$_POST['code'];
			$arr = array();
			$data['arrone'] =$db->get_one("select goods_id,count,userid,name,isget from {$db_mymps}jifen_record where orderCode='".$code."'");
			if($data){
				if($data['isget']==0){
					$data['arrtwo'] = $db->get_one("select prices,detail,img_path from {$db_mymps}jifen_goods where id='".$data['goods_id']."'");
					foreach ($data['arrone'] as $key=>$val){
						$arr['count'] = $val['count'];
						$arr['name'] = iconv('gbk','utf-8',$val['name']);
						$arr['userid'] = isset($val['userid'])?$val['userid']:0;
						$arr['ordercode'] = $code;
					}
					foreach ($data['arrtwo'] as $ke=>$va){
						$arr['prices'] = $va['prices'];
						$arr['detail'] = iconv('gbk','utf-8',$va['detail']);
					}
					$result['data'] =$arr;
	            	$result['status'] =1;
				}else{
					$result['status'] =2; //以兑换，已失效订单
				}
							
			}else{
				$result['status'] =0;		
			}
		echo json_encode($result);
		break;
		case surechange: // 商家兑换商品
			$code = $_POST['code'];//用户id
			$data =$db->get_one("select goods_id from {$db_mymps}jifen_record where orderCode='".$code."'");
			if($data){
				$status = $db->query("update {$db_mymps}jifen_record set isget = 1 where orderCode='".$code."' and isget = 0");
				if($status){
					$result['status'] = 1;
				}else{
					$result['status'] = 0;
				}
			}else{
				$result['status'] = 2;
			}
			echo json_encode($result);
			break;
		case cannelchange:// 取消兑换
			$code = $_POST['code'];
			$data =$db->get_one("select goods_id,count,userid from {$db_mymps}jifen_record where orderCode='".$code."'");
			if($data){
				$status = $db->query("update {$db_mymps}jifen_record set isget = 2 where goods_id='".$data['goods_id']."' and isget = 0");
				$db->query("update {$db_mymps}jifen_mun set v_mun=v_mun+".$data['count']." where userid='".$data['userid']."'");
				if($status){
					$result['status'] = 1;
				}else{
					$result['status'] = 0;
				}
			}else{
				$result['status'] = 2;
			}
			echo json_encode($result);
			break;
		case getagentlist: //获取商家列表
			$catid = isset($_POST['catid'])?$_POST['catid']:'';
			if($catid){
				$sql = "SELECT tname,tel,address,logo,jianjie FROM {$db_mymps}member where catid = '".$catid."'";
			}else{
				$sql ="SELECT tname,tel,address,logo,jianjie FROM {$db_mymps}member where catid != '' or tname !='' or cname!=''";
			}
			$result['data']=$db -> getall($sql);
			if($result['data']){
				foreach ($result['data'] as $ke=>&$va){
						$va['tname'] = iconv('gbk','utf-8',$va['tname']);
						$va['address'] = iconv('gbk','utf-8',$va['address']);
						$va['jianjie'] = iconv('gbk','utf-8',$va['jianjie']);
					}
				$result['status']= 1;
			}else{
				$result['status']= 0;
			}
			echo json_encode($result);
			break;
		case cashgoods: //兑换商品
		$id=$_POST['id'];
		$count=$_POST['count'];
		$userid=$_POST['userid'];
		$prices=$_POST['prices'];
		$name=$_POST['name'];
		$time=time();
		$sumprices=$count*$prices;
		$userinfo=$db->get_one("select v_mun from {$db_mymps}jifen_mun where userid ='".$userid."'");
		if($userinfo){
		  if($userinfo['v_mun']-$sumprices>0){
			  $orderCode=strtoupper(getLetter(characet($name))).build_order_no();
			  $db->query("INSERT INTO `{$db_mymps}jifen_record` (userid,count,detail,type,date,name,goods_id,orderCode) values('".$userid."','".$count."','".$sumprices."',0,'".$time."','".$name."','".$id."','".$orderCode."')");
		      $db->query("update {$db_mymps}jifen_mun set v_mun=v_mun-".$sumprices." where userid='".$userid." '");
			  $db->query("update {$db_mymps}jifen_goods set mun = mun -".$count." where id=".$id);
			  $result['status'] =1;
		  }else{
			  $result['status'] =0;
		  }	
		}else{
			$result['status'] = -1;	
		}
		echo json_encode($result);
		break;
		case cashlist: //兑换商品记录
	    $userid =$_POST['userid'];
		$isget =$_POST['isget'];
		$fields="re.id,re.userid,re.date,re.count,re.orderCode,re.detail as sumprices,re.name,re.isget,go.name,go.img_path,go.detail as goods_detail";
		$where=$isget==-1?"where re.userid='".$userid."'":"where re.userid='".$userid."' and re.isget=".$isget;
        $cashlist=$db->getAll("select ".$fields." from {$db_mymps}jifen_record re join {$db_mymps}jifen_goods go on re.goods_id=go.id ". $where);
		if($cashlist){
			foreach ($cashlist as $key=>&$val){
				$val['title'] = iconv('gbk','utf-8',$val['name']);
				$val['sumprices'] = iconv('gbk','utf-8',$val['sumprices']);
				$val['goods_detail'] = iconv('gbk','utf-8',$val['goods_detail']);
			}
		$result['data']=$cashlist;	
		$result['status']=1;		
		}else{
		$result['status']=0;	
		}
        echo json_encode($result);		
		break;
		case addconcern: //增加关注商品
			$userid = $_POST['userid'];
			$good_id = $_POST['goodid'];
			$good_name = $_POST['goodname'];
			$time = time();
			if($userid){
				$db->query("INSERT INTO `{$db_mymps}concern` (userid,good_id,good_name,time) values('".$userid."','".$good_id."','".$good_name."','".$time."')");
				$result['status'] =1;
			}else{
				$result['status'] =0;
			}
			echo json_encode($result);
		break;
		case cannelconcern: //取消关注
			$id = $_POST['id'];
			$arr=$db->get_one("select id from {$db_mymps}concern where id ='".$id."'");
			if($arr){
				$db->query("update {$db_mymps}concern set flog = 1 where id=".$id);
				$result['message'] = '取消成功';
				$result['status'] = 1;
			}else{
				$result['msg'] = '参数错误！';
				$result['status'] = 0;
			}
			echo json_encode($result);
			break;
		case getconcern: //获取关注列表
			$userid = $_POST['userid'];
			$concernlist=$db->getAll("select id,good_id,good_name from my_concern where userid='".$userid." and flog=0' order by time desc");
			
			if(is_array($concernlist)&&!empty($concernlist)){
				$result['status'] =1;
				$result['data']=$concernlist;
			}else{
				$result['status'] =0;
			}
			echo json_encode($result);
			break;
		case addfankui: //添加反馈
			$userid = $_POST['userid'];
			$time = time();
			$content = $_POST['content'];
			if($userid && $content){
				$db->query("INSERT INTO `{$db_mymps}fankui` (fankui,fuserid,time) values('".$content."','".$userid."','".$time."')");
				$result['status'] =1;
			}else{
				$result['status'] =0;
			}
			echo json_encode($result);
			break;
//		case cashquit:
//		$userid =$_POST['userid'];
//		$goods_id =$_POST['goods_id'];
//		$id =$_POST['id'];
//		$count=$_POST['count'];
//		$sumprices=$_POST['sumprices'];
//		$db->query("update {$db_mymps}jifen_mun set v_mun=v_mun+".$sumprices." where userid='".$userid." '");
//		$db->query("update {$db_mymps}jifen_goods set mun = mun +".$count." where id=".$goods_id);
//		$db->query("update {$db_mymps}jifen_record set isget = 2,date=".time()." where id=".$id);
//		$result['status'] =1;
//		echo json_encode_ex($result);	
//		break;
		case cashmoney: //兑换现金
		$per=10;
		$cashmoney=$_POST['cashmoney'];
		$userid=$_POST['userid'];
		$sumprices=$_POST['cashmoney']*$per;
		$realname=$_POST['realname'];
		$bankno=$_POST['bankno'];
		$bankid=$_POST['bankid'];
		$phone=$_POST['phone'];
		$time=time();
		$ip=$_SERVER['REMOTE_ADDR'];
		$userinfo=$db->get_one("select v_mun from {$db_mymps}jifen_mun where userid ='".$userid."'");
		if($userinfo){
		  if($userinfo['v_mun']-$num>0){
			  $orderCode=strtoupper(getLetter(characet($name))).build_order_no();
			  $db->query("INSERT INTO `{$db_mymps}jifen_record` (userid,count,detail,type,date) values('".$userid."','".$cashmoney."','".$sumprices."',2,'".$time."')");
			  $db->query("INSERT INTO `{$db_mymps}jifen_money` (userid,cashtime,num,ip,bankno,bankid,realname,phone) values('".$userid."','".$time."','".$sumprices."','".$ip."','".$bankno."','".$bankid."','".$realname."','".$phone."')");
		      $db->query("update {$db_mymps}jifen_mun set v_mun=v_mun-".$sumprices." where userid='".$userid." '");
			  $result['status'] =1;
		  }else{
			  $result['status'] =0;
		  }	
		}else{
		$result['status'] = -1;	
		}
		echo json_encode($result);		
		break;
		case banklist: //银行列表
		$banklist=$db->getAll("select bankid,bankname from my_bank");
					$result['data']=$banklist;
		if($banklist[0]) {
			foreach ($result['data'] as $ke=>&$va){
						$va['bankname'] = iconv('gbk','utf-8',$va['bankname']);
					}
			$result['status']=1;
		} else {$result['status'] =0;}
		echo json_encode($result);	
		break;
		case jzorder: //预定家政服务
		$cash=20;
		$address=$_POST['address'];
		$userid=$_POST['userid'];
		$realname=$_POST['realname'];
		$phone=$_POST['phone'];
		$servicetime=$_POST['servicetime'];
		$ip=$_SERVER['REMOTE_ADDR'];
		$userinfo=$db->get_one("select jifen_jzfw from {$db_mymps}jifen_mun where userid ='".$userid."'");
		$jzfwinfo=$db->get_one("select id from {$db_mymps}jifen_jzfw where servicetime='".$servicetime."'");
		if($userinfo&&!$jzfwinfo['id']){
		  if($userinfo['jifen_jzfw']-$cash>0){
		      $db->query("update {$db_mymps}jifen_mun set jifen_jzfw=jifen_jzfw-".$cash." where userid='".$userid." '");
			  $db->query("INSERT INTO `{$db_mymps}jifen_jzfw` (userid,address,ip,servicetime,realname,phone) values('".$userid."','".$address."','".$ip."','".$servicetime."','".$realname."','".$phone."')");
			  $result['status'] =1;
		  }else{
			  $result['status'] =0;
		  }	
		}else{
		$result['status'] = -1;	
		}
		echo json_encode($result);	
		break;
		case jztimeset: //家政时间表
		$fields="t.id,t.timeset,case when ISNULL(jz.id) then 0 else 1 end as isorder";
		$sql="select ".$fields." from my_jzfw_timeset t left JOIN my_jifen_jzfw jz on t.id=jz.tid GROUP BY t.id";

		$result['data']=$db -> getall($sql);
		echo json_encode($result);	
		break;
		case jzjifen: //家政服务积分
		$userid =$_POST['userid'];
		$data=$db->get_one("select jifen_jzfw from {$db_mymps}jifen_mun where userid ='".$userid."'");
		$result['jzjifen'] =$data['jifen_jzfw'];
		$count=$db->getall("select count(type) from my_jifen_jzfw where  userid ='".$userid."' group by type");
		$result['ordering']=$count[0][0];
		$result['ordered']=$count[1][0];
		echo json_encode($result);	
		break;
		case getgoods: //确认未领取的商品
		$id =$_POST['id'];
		$goods_id  =$_POST['goods_id'];
		$myCode =$_POST['myCode'];
		$fields="re.id,re.name,re.date,re.count,re.detail as sumprices";
		$cashinfo=$db->get_one("select id from {$db_mymps}jifen_goods where id ='".$goods_id."' and mycode='".$myCode."'   ");
		if($cashinfo){
			$data=$db->get_one("select id,name,date,count,detail as sumprices from {$db_mymps}jifen_record where id='".$id."' ");
			//print_r("update {$db_mymps}jifen_record  set isget =1 where id='".$id."'  ");
		$db->query("update {$db_mymps}jifen_record  set isget =1 where id='".$id."'  ");
			$result['data'] = $data;
			$result['status'] = 1;
		}else{
			$result['status'] = 0;
		}
        echo json_encode($result); 
		break;
		case all_list:
			$type = $_POST['type'];
			if($type){
				$where = "type = ".$type;  //type :0 预约中，1，已完成预约，2取消预约的
			}else{
				$where = ' 1=1 ';
			}
			if($id){
				$data=$db->get_one("select * from {$db_mymps}jifen_jzfw where ".$where);
			}
			if($data){
				$result['data'] = $data;
				$result['status'] = 1;
			}else{
				$result['status'] = 0;
			}
			echo json_encode($result);
			break;
		case jzlist: //个人家政列表
			$id =$_POST['userid'];
			$type = $_POST['type'];
			if($type){
				$where = " and type = ".$type;  //type :0 预约中，1，已完成预约，2取消预约的
			}else{
				$where = '';
			}
			if($id){
				$data=$db->get_one("select * from {$db_mymps}jifen_jzfw where userid ='".$userid."'".$where);
			}
			if($data){
				$result['data'] = $data;
				$result['status'] = 1;
			}else{
				$result['status'] = 0;
			}
			echo json_encode($result);
		break;
		case qxjzfw: //取消家政服务
			$userid = $_POST['userid'];
			$id = $_POST['id'];
			$cash = 20;
			$data=$db->get_one("select id from {$db_mymps}jifen_jzfw where userid ='".$userid."' and type=0 and id = $id ");
			if($data){
				$db->query("update {$db_mymps}jifen_jzfw  set type = 2 where type=0 and userid='".$userid."and id=$id");
				$db->query("update {$db_mymps}jifen_mun  set jifen_jzfw=jifen_jzfw+".$cash." where type=0 and userid='".$userid);// 更新家政积分数量
				$result['data'] = $data;
				$result['status'] = 1;
			}else{
				$result['status'] = 0;
			}
			echo json_encode($result);
			break;
		case surejz: //确认家政服务完成  预留
			
			break;
		case login: //登录
		$userid = $_POST['userid'];
		$password = $_POST['password'];
		if($s_uid  = $db -> getOne("SELECT userid FROM `{$db_mymps}member` WHERE userid='$userid' AND userpwd='".md5($password)."'")){
			$result['status'] =1;
			$result['userid']=$userid;
		}else{
			$result['status'] = 0;
		}
		//$result['msg']='登陆成功';
		echo json_encode($result);
		break;
		case pwdup: //修改商户密码
		$userid	=	$_POST['userid'];
		$oldpwd = md5($_POST['password']);
	 	$passwd	=	md5($_POST['pwdxin']);
	 	$surepasswd	=	md5($_POST['pwdsure']);
	 	if($oldpwd==$passwd){
	 		$result['status'] = 0; // 两次密码输入相同
	 		echo json_encode($result);
	 	}else if($surepasswd!=$passwd){
	 		$result['status'] = -1; //确认密码输入有误
	 	}else{
		 	if($s_uid  = $db -> getOne("SELECT userid FROM `{$db_mymps}member` WHERE userid='$userid' AND userpwd='".$oldpwd."'")){
				$sql_pw	=	"UPDATE `my_member` SET `userpwd`='$passwd' where `userid`='$userid'";
	 			$que_pw	=	mysql_query($sql_pw);
	 			$result['status'] =1; //成功
			}else{
				$result['status'] =-2; //用户名或者密码不正确
			}
	 	}
	 	echo json_encode($result);
		break;
		case reg: //注册
		$userid=$_POST['phone'];
		$password =$_POST['password'];
		$rands =$_POST['rands'];
		if($_SESSION['sess_yzhm']==$rands){
			//echo 1;
			if($password&&$userid){
				$id=member_reg($userid,md5($password),'','','','','');
				if($id){
					$result['userid'] =$userid;
					$result['status'] =1;
				}  
				else{
					$result['status'] =0;
				}
			}else{
				$result['status']=-2;
			}
		}else{
			$result['status'] = -3;
		}
		$result['sess_yzhm']= $_SESSION['sess_yzhm'];
		echo json_encode($result);
		break;
		case getpm: //短消息
		$id=$_POST['id'];
		$s_uid =$_POST['userid'];
	    if(!empty($id)){
		$db -> query("UPDATE `{$db_mymps}member_pm` SET `if_read` = '1' WHERE id = '$id'");
		$pm = $db -> getRow("SELECT * FROM `{$db_mymps}member_pm` WHERE id = '$id'");
		if($pm['id'] == '') write_msg('','?m=pm&error=12&ac='.$ac.'&page='.$page);
	    }elseif(empty($id) && in_array($ac,array('inbox','outbox'))){
		$where = $ac == 'inbox' ? " WHERE touser = '$s_uid'" : " WHERE fromuser = '$s_uid'";
		$sql 	  = "SELECT * FROM `{$db_mymps}member_pm` $where ORDER BY pubtime DESC";
		$rows_num = mymps_count("member_pm",$where);
		$param	  = setParam(array('m','ac'));
		$pm 	  = page1($sql);
	   }
		break;
	}
	if($_GET['type']=='jgoods'){
		/*
		*积分上平
		*/
		$arrlist=getJgoodsList();
		json_echo($arrlist);	
	}else{
		 if($_GET['type']=='jget'){
			 /*
			 *
			*必须传入 	$myId	=	$_POST['myId'];
			*	三个全局变量
			*/
			if($_GET['c']=='jm'){
				json_echo($jifen_mun);		//个人积分数
			}elseif($_GET['c']=='jr'){
				json_echo($jq_InRecord ) ;	//积分收取记录
			}elseif($_GET['c']=='jc'){				
				echo '{"0":"'.$InRecord_num .'"}';	//积分记录条数
			}
			
			
			
			/*			******获取积分******
			*	$_GET['p']=='g2'			请求地址：eg:http://www.ugohb.com/app/app.php?j=index&type=jget&p=g2		
			*	
			*	$count		=	$_POST['count'];		积分数
			*	$passCode	=	$_POST['passCode'];		商家码
			*	$myId	 	=	$_POST['myId'];			用户ID
			*	
			*/
			
			
			/*			****积分兑换处理***
			*	$_GET['p']=='b'			请求地址：eg:http://www.ugohb.com/app/app.php?j=index&type=jget&p=g	
			*	$buyMun=$_POST['buyMun'];		购买数量
			*	$goods_id=$_POST['id'];			商品ID
			*	$s_uid=$_POST['myId'];			用户ID
			*/
		
		 }
		
		
		
	}
	
}


/**
*json_echo（）
*json数据格式输出二维数组 json_echo($arrlist);
*by詹英2015年10月
*/

function json_echo($arrlist){
	$i=0;	
	echo '[';
	foreach($arrlist as $k=>$v){
		$i++;
		echo '{';
		$j=0;
		foreach($v as $key=>$val){
			$j++;
			echo '"'.$key.'":"'.characet($val).'"'; 
			if($j!=count($v)){
				echo ', ';
			}
			
		}
		echo '}';
		if($i!=count($arrlist)){
			echo ', ';
		}			
	}
echo ']';
}


/**
*json_echo（）
*json数据格式输出一维数组json_print($arrlist)
*by詹英2015年10月
*/

function json_print($arrlist){
	$i=0;
	echo '{';
	foreach($arrlist as $k=>$v){
		$i++;
		echo '"'.$k.'":"'.characet($v).'"'; 
		if($i!=count($arrlist)){
			echo ', ';
		}
	}
	echo '}';
}
function build_order_no()
{
    return date('Ymd').substr(implode(NULL, array_map('ord', str_split(substr(uniqid(), 7, 13), 1))), 0, 8);
}
function getLetter($string)
{
    $len=mb_strlen($string,'utf-8');
    $pinyin='';
   for ($i=0; $i<$len; $i++) 
   {
      $word = mb_substr($string,$i,1,"UTF-8");
      $pinyin.= getfirstchar($word);
   }
    return $pinyin;
}
function getfirstchar($s0) {
    $fchar = ord(mb_substr($s0, 0, 1,"UTF-8"));
    if (($fchar >= ord("a") and $fchar <= ord("z"))or($fchar >= ord("A") and $fchar <= ord("Z"))) return strtoupper(chr($fchar));
     $s = iconv("UTF-8", "gb2312//IGNORE", $s0);
    $asc = ord($s{0}) * 256 + ord($s{1})-65536;
    if ($asc >= -20319 and $asc <= -20284)return "A";
    if ($asc >= -20283 and $asc <= -19776)return "B";
    if ($asc >= -19775 and $asc <= -19219)return "C";
    if ($asc >= -19218 and $asc <= -18711)return "D";
    if ($asc >= -18710 and $asc <= -18527)return "E";
    if ($asc >= -18526 and $asc <= -18240)return "F";
    if ($asc >= -18239 and $asc <= -17923)return "G";
    if ($asc >= -17922 and $asc <= -17418)return "H";
    if ($asc >= -17417 and $asc <= -16475)return "J";
    if ($asc >= -16474 and $asc <= -16213)return "K";
    if ($asc >= -16212 and $asc <= -15641)return "L";
    if ($asc >= -15640 and $asc <= -15166)return "M";
    if ($asc >= -15165 and $asc <= -14923)return "N";
    if ($asc >= -14922 and $asc <= -14915)return "O";
    if ($asc >= -14914 and $asc <= -14631)return "P";
    if ($asc >= -14630 and $asc <= -14150)return "Q";
    if ($asc >= -14149 and $asc <= -14091)return "R";
    if ($asc >= -14090 and $asc <= -13319)return "S";
    if ($asc >= -13318 and $asc <= -12839)return "T";
    if ($asc >= -12838 and $asc <= -12557)return "W";
    if ($asc >= -12556 and $asc <= -11848)return "X";
    if ($asc >= -11847 and $asc <= -11056)return "Y";
    if ($asc >= -11055 and $asc <= -10247)return "Z";
    return null;
}

function member_reg($userid,$userpwd,$email='',$safequestion='',$safeanswer='',$openid='',$cname=''){
	global $mymps_global,$db,$db_mymps,$member_log,$timestamp;
	
	if($openid){
		if($db->getOne("SELECT id FROM `{$db_mymps}member` WHERE userid = '$userid'")) write_msg('openid已重复!请重新完善帐号信息！');
	}
	
	$ip = GetIP();
	$safeanswer = trim($safeanswer);
	$row 		= $db->getRow("SELECT money_own FROM `{$db_mymps}member_level` WHERE id = '1'"); 
	$money_own	= $row['money_own'];
	$face 		= "";
	
	$sql 		= "INSERT INTO `{$db_mymps}member`(id,userid,userpwd,logo,prelogo,email,safequestion,safeanswer,levelid,joinip,loginip,jointime,logintime,money_own,openid,cname) VALUES ('','$userid','$userpwd','$face','$face','$email','$safequestion','$safeanswer','1','$ip','$ip','$timestamp','$timestamp','$money_own','$openid','$cname')";
	
	$db -> query($sql);
	return $db;
}

?>