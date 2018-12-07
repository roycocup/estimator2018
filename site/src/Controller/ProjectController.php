<?php

namespace App\Controller;

use App\Entity\Answer;
use App\Entity\Project;
use App\Entity\Question;
use App\Form\ProjectType;
use App\Repository\ProjectRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

/**
 * @Route("/project")
 */
class ProjectController extends Controller
{
    /**
     * @Route("/", name="project_index", methods="GET")
     */
    public function index(ProjectRepository $projectRepository): Response
    {
        return $this->render('project/index.html.twig', ['projects' => $projectRepository->findAll()]);
    }

    /**
     * @Route("/new", name="project_new")
     */
    public function new(Request $request): Response
    {
        $questionRepo = $this->getDoctrine()->getRepository(Question::class);

        return $this->render('project/new2.html.twig', [
            'questions' => $questionRepo->findAll(),
        ]);
    }

    /**
     * @Route("/{id}", name="project_show", methods="GET")
     */
    public function show(Project $project): Response
    {
        return $this->render('project/show.html.twig', ['project' => $project]);
    }

    /**
     * @Route("/{id}/edit", name="project_edit", methods="GET|POST")
     */
    public function edit(Request $request, Project $project): Response
    {
        $form = $this->createForm(ProjectType::class, $project);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $this->getDoctrine()->getManager()->flush();

            return $this->redirectToRoute('project_index', ['id' => $project->getId()]);
        }

        return $this->render('project/edit.html.twig', [
            'project' => $project,
            'form' => $form->createView(),
        ]);
    }

    /**
     * @Route("/{id}", name="project_delete", methods="DELETE")
     */
    public function delete(Request $request, Project $project): Response
    {
        if ($this->isCsrfTokenValid('delete'.$project->getId(), $request->request->get('_token'))) {
            $em = $this->getDoctrine()->getManager();
            $em->remove($project);
            $em->flush();
        }

        return $this->redirectToRoute('project_index');
    }

    /**
     * @Route("/handle_new", name="project_handle_new", methods="GET|POST")
     */
    public function handleForm(Request $request): Response
    {
        $project = new Project();
        $em = $this->getDoctrine()->getManager();
        $questionRepo = $this->getDoctrine()->getRepository(Question::class);


        // if we ask for the keys we can then get the corresponding questions
        $answerKeys = $request->request->keys();
        foreach ($answerKeys as $answerKey){
            $formAnswer = $request->get($answerKey);
            $questionId = substr($answerKey, 1);
            $answer = new Answer();
            $answer->setAnswer($formAnswer);
            $answer->setQuestion($questionRepo->find((int) $questionId));
            $answer->setProject($project);
            $project->addAnswer($answer);
            $em->persist($answer);
        }

        $em->persist($project);
        $em->flush();

        return $this->redirectToRoute('project_index', ['id' => $project->getId()]);
    }

    /**
     * @Route("/process/{id}", name="project_process")
     */
    public function process(Request $request, Project $project)
    {
        $em = $this->getDoctrine()->getManager();
        $score = 0;
        foreach ($project->getAnswers() as $answer){
            /** @var  $answer Answer */
            $this->toNumber($answer);
            $weight = $answer->getQuestion()->getWeight();

            if (empty($answer->getAnswer()))
                $answer->setAnswer(0);

            if ($answer->getQuestion()->getName() == "author_is_same" || $answer->getQuestion()->getName() == "server_control" ) {
                $answer->setLastScore(-$weight);
                $score -= $weight;
            } elseif($answer->getQuestion()->getName() == "number_of_developers") {
                $answer->setLastScore(-1 * ($weight * $answer->getAnswer()));
                $score -= $weight * $answer->getAnswer();
            } elseif ($answer->getQuestion()->getName() == "server_control" && $answer->getAnswer() == 0) {
                $answer->setLastScore(-$weight);
                $score -= $weight;
            } elseif ($answer->getQuestion()->getName() == "domain_familiarity" && $answer->getAnswer() == 0) {
                $answer->setLastScore(-$weight);
                $score -= $weight;
            } else {
                $answer->setLastScore($answer->getAnswer() * $weight);
                $score += ($answer->getAnswer() * $weight);

            }
            $em->persist($answer);
        }

        $project->setScore($score);

        $maxScore = 60;
        $maxTime = 365;
        $estimation = ($score * $maxTime) / $maxScore;
        $minEstimation = 1;
        $estimation = ($estimation < $minEstimation)? 0 : $estimation;
        $project->setEstimation(round($estimation, 2));


        $em->persist($project);
        $em->flush();

        return $this->redirectToRoute('project_show',['id' => $project->getId()] );
    }

    /**
     * transform all string boolean answers to numbers
     * @param $answer
     */
    public function toNumber(&$answer)
    {
        if (is_string($answer->getAnswer())) {
            if ($answer->getAnswer() == 'y' || $answer->getAnswer() == 'on') {
                $answer->setAnswer(1);
            } elseif($answer->getAnswer() == 'n') {
                $answer->setAnswer(0);
            }
        }
    }

}
