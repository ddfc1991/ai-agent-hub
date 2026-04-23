import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

void main() {
  runApp(const AgentHubApp());
}

class AgentHubApp extends StatelessWidget {
  const AgentHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Agent Hub',
      theme: ThemeData(
        primaryColor: Colors.blueAccent,
        useMaterial3: true,
      ),
      home: const MainHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainHomePage extends StatefulWidget {
  const MainHomePage({super.key});

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  int pageIndex = 0;

  final List<Widget> pages = [
    AgentMarketPage(),
    SkillManagePage(),
    AgentCooperatePage(),
    SettingPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex,
        onTap: (i)=>setState(()=>pageIndex=i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.store),label:"Agent市场"),
          BottomNavigationBarItem(icon: Icon(Icons.extension),label:"技能Skill"),
          BottomNavigationBarItem(icon: Icon(Icons.group_work),label:"多Agent协同"),
          BottomNavigationBarItem(icon: Icon(Icons.settings),label:"设置")
        ],
      ),
    );
  }
}

class AgentMarketPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("AI Agent 市场")),
      body: ListView(
        padding: EdgeInsets.all(14),
        children: [
          agentCard("通用对话Agent","云端+本地双部署"),
          agentCard("代码Agent","编程、脚本生成"),
          agentCard("推理Agent","深度思考逻辑"),
          agentCard("工具Agent","联网调用工具"),
          SizedBox(height:20),
          ElevatedButton(
            onPressed: (){},
            child: Text("从Github拉取更多Agent"),
          )
        ],
      ),
    );
  }

  Widget agentCard(String name,String desc){
    return Card(
      margin: EdgeInsets.only(bottom:10),
      child: ListTile(
        title: Text(name,style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(desc),
        trailing: Icon(Icons.download),
        onTap: (){},
      ),
    );
  }
}

class SkillManagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Skill 技能插件")),
      body: ListView(
        padding: EdgeInsets.all(14),
        children: [
          skillCard("联网搜索","实时网络信息"),
          skillCard("文件读写","读取手机本地文件"),
          skillCard("长期记忆","AI记忆储存"),
          skillCard("任务拆解","复杂任务分步执行"),
          SizedBox(height:20),
          ElevatedButton(onPressed:(){},child: Text("安装本地Skill"))
        ],
      ),
    );
  }
  Widget skillCard(String name,String desc){
    return Card(
      margin: EdgeInsets.only(bottom:10),
      child: ListTile(
        title: Text(name),
        subtitle: Text(desc),
        trailing: Switch(value:true,onChanged:(v){}),
      ),
    );
  }
}

class AgentCooperatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("多Agent协同任务")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("当前运行智能体",style:TextStyle(fontSize:16,fontWeight:FontWeight.bold)),
            SizedBox(height:10),
            Wrap(
              spacing:8,
              children: [
                Chip(label:Text("对话Agent")),
                Chip(label:Text("推理Agent")),
                Chip(label:Text("工具Agent")),
              ],
            ),
            SizedBox(height:20),
            LinearProgressIndicator(value:0.65),
            SizedBox(height:10),
            Text("任务进度：65% 多智能体联合执行中"),
            Spacer(),
            TextField(
