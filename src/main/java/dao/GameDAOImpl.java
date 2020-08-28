package dao;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.bson.Document;
import org.springframework.stereotype.Repository;

import com.google.gson.Gson;
import com.mongodb.MongoClient;
import com.mongodb.MongoClientURI;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;

import vo.GameVO;

@Repository
public class GameDAOImpl {
	MongoClientURI uri = null;
	MongoClient mongoClient = null;
	MongoDatabase mongodb = null;
	MongoCollection<Document> collection = null;
	MongoCursor<Document> cursor = null;
	
	public GameDAOImpl(String kind) {
		uri = new MongoClientURI(
				"mongodb://boxak:Second142857%21@exercise-shard-00-00-atylc.mongodb.net:27017,exercise-shard-00-01-atylc.mongodb.net:27017,exercise-shard-00-02-atylc.mongodb.net:27017/test?ssl=true&replicaSet=Exercise-shard-0&authSource=admin&retryWrites=true&w=majority"
		);
		mongoClient = new MongoClient(uri);
		mongodb = mongoClient.getDatabase("GameDB");
		collection = mongodb.getCollection(kind+"Info");
	}
	
	public boolean insert(GameVO vo) {
		boolean result = false;
		try {
			Document document = new Document();
			document.put("score", vo.getScore());
			
			int cnt = (int)collection.countDocuments(Filters.eq("name", vo.getName()));
			if(cnt==0) {
				document.put("name", vo.getName());
				collection.insertOne(document);
			}
			else {
				document = collection.find(Filters.eq("name", vo.getName())).first();
				String json = document.toJson();
				Gson gson = new Gson();
				GameVO vo1 = gson.fromJson(json, GameVO.class);
				if(vo1.getScore()<vo.getScore()) {
					document = new Document("score",vo.getScore());
					collection.updateOne(Filters.eq("name", vo.getName()), new Document("$set",document));
				}
			}
			
			result = true;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public List<GameVO> listAll(){
		List<GameVO> list = new ArrayList<>();
		cursor = collection.find().cursor();
		while(cursor.hasNext()) {
			Document document = cursor.next();
			String json = document.toJson();
			Gson gson = new Gson();
			GameVO vo = gson.fromJson(json, GameVO.class);
			list.add(vo);
		}
		Collections.sort(list);
		return list;
	}
	
}
