package com.my.game;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dao.GameDAOImpl;
import vo.GameVO;

@Controller
public class GameController {
	@RequestMapping("/{game}")
	public String getGame(@PathVariable String game,
						 HttpSession session) {
		session.setAttribute("gameKind", game);
		return game+"game";
	}
	
	@ResponseBody
	@RequestMapping(value="/insertScore",produces="application/json; charset=UTF-8")
	public String insertScore(String kind,
									@ModelAttribute("vo")GameVO vo) {
		GameDAOImpl dao = new GameDAOImpl(kind);
		boolean result = dao.insert(vo);
		String msg = "";
		if(result) msg = "점수가 입력되었습니다.";
		else msg = "오류가 발생했습니다!";
		
		return msg;
	}
	
	@RequestMapping("/rankingBoard")
	public ModelAndView listAll(String kind) {
		GameDAOImpl dao = new GameDAOImpl(kind);
		
		List<GameVO> list = dao.listAll();
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("list", list);
		mav.setViewName("rankingBoard");
		return mav;
	}
}
