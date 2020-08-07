package com.synergy.socdoc.admin;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.synergy.socdoc.common.MyUtil;
import com.synergy.socdoc.member.HealthInfoVO;
import com.synergy.socdoc.member.MemberVO;
import com.synergy.socdoc.member.NoticeVO;
import com.synergy.socdoc.member.QnaBoardVO;


@Component
@Controller
public class AdminController {

	@Autowired
	private InterAdminService service;

	/* 회원관리 */ 
	@RequestMapping(value = "/adminMemberMng.sd", method = RequestMethod.GET, produces = "text/plain;charset=UTF-8")
	public ModelAndView adminMemberMng(HttpServletRequest request, ModelAndView mav) {
		
		/*
		HashMap<String, List<MemberVO>> map = service.selectMemberList();
		request.setAttribute("membervoList", map.get("membervoList"));
		
		return "admin/adminMemberMng.tiles3";
		*/
		
		
		List<MemberVO> membervoList = null;
		
		String searchType = request.getParameter("searchType");
		String searchWord = request.getParameter("searchWord");
		
	//	System.out.println(searchWord+"------------------");
		
		String str_currentShowPageNo = request.getParameter("currentShowPageNo");
		
		if(searchWord == null || searchWord.trim().isEmpty()) {

			searchWord = "";
		
		}
		
		HashMap<String, String> paraMap = new HashMap<>();
		
		paraMap.put("searchType", searchType);
		paraMap.put("searchWord", searchWord);
		
		int totalCount = 0;
		int sizePerPage = 5;
		int currentShowPageNo = 0;
		int totalPage = 0;
		
		int startRno = 0;
		int endRno = 0;
		
		totalCount = service.getTotalCount(paraMap);
		
		totalPage = (int)Math.ceil((double)totalCount/sizePerPage);
		
		if(str_currentShowPageNo == null) {
			
			currentShowPageNo = 1;
		}
		else {
			try {
				currentShowPageNo = Integer.parseInt(str_currentShowPageNo);
				
				if(currentShowPageNo < 1 || currentShowPageNo > totalPage) {
					currentShowPageNo = 1;
				}
				
			} catch (NumberFormatException e) {
				currentShowPageNo = 1;
			}
		}
		
		startRno = ((currentShowPageNo - 1)*sizePerPage)+1;
		endRno = startRno + sizePerPage - 1;
		
		paraMap.put("startRno", String.valueOf(startRno));
		paraMap.put("endRno", String.valueOf(endRno));
 
	//	System.out.println(searchType+"/"+searchWord+"/"+startRno+"/"+endRno);
		
		membervoList = service.memberListSearchWithPaging(paraMap);
		
		if(!"".equals(searchWord)) {
			mav.addObject("paraMap", paraMap);
		}
		
		String pageBar = "<ul style='list-style: none;'>";
		
		int blockSize = 10;
		
		int loop = 1;
		
		int pageNo = ((currentShowPageNo -1)/blockSize) * blockSize + 1;
		
		String url = "adminMemberMng.sd";
		
		// === [이전] 만들기 ===
		if(pageNo != 1) {
			pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>";
		}
		
		while (!(loop > blockSize || pageNo > totalPage )) {

			
			if(pageNo == currentShowPageNo) {
				pageBar += "<li style='display:inline-block; width:30px; font-size: 12pt; border: solid 1px solid; color: red; padding: 2px 4px;'>" + pageNo + "</li>";
			}
			else {
				pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>";
			}
			
			loop ++;
			pageNo ++;
			
		} // end of while ----------------------------
		
		
		// === [다음] 만들기 ===
		if( !(pageNo > totalPage) ) {
		
			pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+pageNo+"'>[다음]</a></li>";		
		
		}
		
		pageBar += "</ul>";
		
		mav.addObject("pageBar", pageBar);

		String gobackURL = MyUtil.getCurrentURL(request);
		
		mav.addObject("gobackURL", gobackURL);
		
		mav.addObject("membervoList", membervoList);
		mav.addObject("totalCount", totalCount);
		mav.setViewName("admin/adminMemberMng.tiles3");
		
		return mav;
		
	}
	

	/* 병원회원관리 */	
	@RequestMapping(value = "/adminHospitalMng.sd", method = RequestMethod.GET, produces = "text/plain;charset=UTF-8")
	public String adminHospitalMng(HttpServletRequest request) {
		
		return "admin/adminHospitalMng.tiles3";
	}
	
	/* 병원등록 */
	@RequestMapping(value = "/hospitalInfo.sd", method = RequestMethod.GET, produces = "text/plain;charset=UTF-8")
	public String hospitalInfo(HttpServletRequest request) {
		
		return "admin/hospitalInfo.tiles3";
	}
	
	/* 공지사항관리 */
	@RequestMapping(value = "/adminNoticeMng.sd", method = RequestMethod.GET, produces = "text/plain;charset=UTF-8")
	public String adminNoticeMng(HttpServletRequest request) {
		
		HashMap<String, List<NoticeVO>> map = service.selectNoticeList();
		request.setAttribute("noticevoList", map.get("noticevoList"));
		
		return "admin/adminNoticeMng.tiles3";
	}
	
	/* 공지사항 글보기 */
	@RequestMapping(value = "/noticeView.sd", method = RequestMethod.GET, produces = "text/plain;charset=UTF-8")
	public ModelAndView noticeView(HttpServletRequest request, ModelAndView mav) {
		
		String noticeSeq = request.getParameter("noticeSeq");
		
	//	System.out.println("공지사항 seq 잘오나? : " + noticeSeq);
		
		String gobackURL = request.getParameter("gobackURL");
		mav.addObject("gobackURL", gobackURL);

		NoticeVO noticevo = null;

		noticevo = service.getView(noticeSeq);
		
		mav.addObject("noticevo", noticevo);
		mav.setViewName("admin/noticeView.tiles3");
		
		return mav;
	}
	
	/* 공지사항 글쓰기 */
	@RequestMapping(value = "/noticeWrite.sd", method = RequestMethod.GET, produces = "text/plain;charset=UTF-8")
	public String noticeWrite(HttpServletRequest request) {
		
		return "admin/noticeWrite.tiles3";
	}
	
	/* 건강정보관리 */
	@RequestMapping(value = "/healthInfoMng.sd", method = RequestMethod.GET, produces = "text/plain;charset=UTF-8")
	public String healthInfoMng(HttpServletRequest request) {
		
		HashMap<String, List<HealthInfoVO>> map = service.selectHealthInfoList();
		request.setAttribute("healthvoList", map.get("healthvoList"));
		
		return "admin/healthInfoMng.tiles3";
	}

	/* 건강정보 글보기 */
	@RequestMapping(value = "/healthView.sd", method = RequestMethod.GET, produces = "text/plain;charset=UTF-8")
	public String healthView(HttpServletRequest request) {
		
		return "admin/healthView.tiles3";
	}

	/* 건강정보 글쓰기 */
	@RequestMapping(value = "/healthWrite.sd", method = RequestMethod.GET, produces = "text/plain;charset=UTF-8")
	public String healthWrite(HttpServletRequest request) {
		
		return "admin/healthWrite.tiles3";
	}
	
	/* 후기관리 */
	@RequestMapping(value = "/reviewMng.sd", method = RequestMethod.GET, produces = "text/plain;charset=UTF-8")
	public String reviewMng(HttpServletRequest request) {
		
		return "admin/reviewMng.tiles3";
	}
	
	/* 문의관리 */
	@RequestMapping(value = "/qnaMng.sd", method = RequestMethod.GET, produces = "text/plain;charset=UTF-8")
	public String qnaMng(HttpServletRequest request) {
		HashMap<String, List<QnaBoardVO>> map = service.selectQnAList();
		request.setAttribute("qnavoList", map.get("qnavoList"));
		
		return "admin/qnaMng.tiles3";
	}
	
	/* 문의관리 답변쓰기 */
	@RequestMapping(value = "/qnaAnswer.sd", method = RequestMethod.GET, produces = "text/plain;charset=UTF-8")
	public String qnaAnswer(HttpServletRequest request) {
		
		return "admin/qnaAnswer.tiles3";
	}
	
	/* FAQ관리 */
	@RequestMapping(value = "/faqMng.sd", method = RequestMethod.GET, produces = "text/plain;charset=UTF-8")
	public String faqMng(HttpServletRequest request) {
		
		return "admin/faqMng.tiles3";
	}
	
	/* FAQ 글쓰기 */
	@RequestMapping(value = "/faqWrite.sd", method = RequestMethod.GET, produces = "text/plain;charset=UTF-8")
	public String faqWrite(HttpServletRequest request) {
		
		return "admin/faqWrite.tiles3";
	}
	
	
}
