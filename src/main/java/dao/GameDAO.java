package dao;

import java.util.List;

import vo.GameVO;

public interface GameDAO {
	public boolean insert(GameVO vo);
	public List<GameVO> listAll();
}
